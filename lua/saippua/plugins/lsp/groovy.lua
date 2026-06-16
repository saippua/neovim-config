-- groovy-language-server (Prominic) needs some hand-holding:
--   1. It can't discover Jenkins core/plugin jars on its own, so we feed it
--      a classpath built from a local docker copy (see setup_jenkins_lsp.sh).
--   2. It emits spurious "Invalid duplicate class definition" diagnostics,
--      which we filter from publishDiagnostics.
--   3. It only indexes files it has seen via textDocument/didOpen, so
--      cross-file go-to-definition is broken until each file is opened.
--      We work around this by preloading every .groovy file in the workspace
--      as a hidden buffer on first attach.

local M = {}

function M.setup()
  local jenkins_classpath = { "/home/huawei/jenkins_libs/core/*" }
  for _, dir in ipairs(vim.fn.glob("/home/huawei/jenkins_libs/plugins/*/WEB-INF/lib", true, true)) do
    table.insert(jenkins_classpath, dir .. "/*")
  end

  local orig_publish = vim.lsp.handlers["textDocument/publishDiagnostics"]
  vim.lsp.config('groovyls', {
    cmd = { 'groovy-language-server' },
    settings = {
      groovy = {
        classpath = jenkins_classpath,
      }
    },
    handlers = {
      ["textDocument/publishDiagnostics"] = function(err, result, ctx, config)
        if result and result.diagnostics then
          result.diagnostics = vim.tbl_filter(function(d)
            return not (d.message and d.message:find("Invalid duplicate class definition", 1, true))
          end, result.diagnostics)
        end
        orig_publish(err, result, ctx, config)
      end,
    },
  })
  vim.lsp.enable('groovyls')

  local preloaded = {}
  vim.api.nvim_create_autocmd('LspAttach', {
    callback = function(args)
      local client = vim.lsp.get_client_by_id(args.data.client_id)
      if not client or client.name ~= 'groovyls' then return end
      if preloaded[client.id] then return end
      preloaded[client.id] = true

      local root = client.config.root_dir or vim.fn.getcwd()
      local scan_root = vim.fn.isdirectory(root .. '/jenkins') == 1
        and (root .. '/jenkins') or root

      vim.schedule(function()
        local files = vim.fn.globpath(scan_root, '**/*.groovy', false, true)
        local current = vim.api.nvim_buf_get_name(args.buf)
        for _, f in ipairs(files) do
          if f ~= current then
            local bufnr = vim.fn.bufadd(f)
            pcall(vim.cmd, ('noswapfile call bufload(%d)'):format(bufnr))
            vim.bo[bufnr].buflisted = false
          end
        end
      end)
    end,
  })
end

return M
