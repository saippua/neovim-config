return {
  'frankroeder/parrot.nvim',
  dependencies = { 'ibhagwan/fzf-lua', 'nvim-lua/plenary.nvim' },
  -- parrot errors on startup without rg or an API key
  cond = vim.fn.executable('rg') == 1 and os.getenv('ANTHROPIC_API_KEY') ~= nil,
  config = function()
    require("parrot").setup {
      -- Providers must be explicitly set up to make them available.
      providers = {
        anthropic = {
          name = "anthropic",
          endpoint = "https://api.anthropic.com/v1/messages",
          model_endpoint = "https://api.anthropic.com/v1/models",
          api_key = os.getenv "ANTHROPIC_API_KEY",
          params = {
            chat = { max_tokens = 4096 },
            command = { max_tokens = 4096 },
          },
          topic = {
            model = "claude-haiku-4-5-20251001",
            params = { max_tokens = 32 },
          },
          headers = function(self)
            return {
              ["Content-Type"] = "application/json",
              ["x-api-key"] = self.api_key,
              ["anthropic-version"] = "2023-06-01",
            }
          end,
          models = {
            "claude-opus-4-8",
          },
          preprocess_payload = function(payload)
            for _, message in ipairs(payload.messages) do
              message.content = message.content:gsub("^%s*(.-)%s*$", "%1")
            end
            if payload.messages[1] and payload.messages[1].role == "system" then
              -- remove the first message that serves as the system prompt as anthropic
              -- expects the system prompt to be part of the API call body and not the messages
              payload.system = payload.messages[1].content
              table.remove(payload.messages, 1)
            end
            return payload
          end,
        },
      },
    }
  end,
}
