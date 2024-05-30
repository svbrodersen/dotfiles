return {
  "David-Kunz/gen.nvim",
  init = function()
    require("gen").prompts["Enhance_Grammar_Spelling"] = {
      prompt = "Modify the following text to improve grammar and spelling, \z
        keep any special symbols, characters or links already present, just \z
        output the final text without additional quotes around it or explanations of what was done:\n$text",
      replace = true,
    }
    require("gen").prompts["Enhance_Wording"] = {
      prompt = "Modify the following text to use better wording, keep any \z
        special symbols, characters or links, just output the final text without \z
        additional quotes around it or explanations of what was done:\n$text",
      replace = true,
    }
    require("gen").prompts["Enhance_Prompt"] = {
      prompt = "Enhance the following text to improve grammar, spellling and wording, \z
        keep all special characters, symbols or links already present, $input, \z
        just output the modified text without any other prompt or quotes around \z
        it or explanations of what was done:\n$text",
      replace = true,
    }
  end,
  opts = {
    model = "dolphin-llama3", -- The default model to use.
    host = "localhost", -- The host running the Ollama service.
    port = "11434", -- The port on which the Ollama service is listening.
    display_mode = "float", -- The display mode. Can be "float" or "split".
    show_prompt = false, -- Shows the Prompt submitted to Ollama.
    show_model = true, -- Displays which model you are using at the beginning of your chat session.
    quit_map = "q", -- set keymap for quit
    no_auto_close = false, -- Never closes the window automatically.
    init = function(options)
      pcall(io.popen, "ollama serve > /dev/null 2>&1 &")
    end,
    -- Function to initialize Ollama
    command = function(options)
      return "curl --silent --no-buffer -X POST http://" .. options.host .. ":" .. options.port .. "/api/chat -d $body"
    end,
    -- The command for the Ollama service. You can use placeholders $prompt, $model and $body (shellescaped).
    -- This can also be a command string.
    -- The executed command must return a JSON object with { response, context }
    -- (context property is optional).
    -- list_models = '<omitted lua function>', -- Retrieves a list of model names
    debug = false, -- Prints errors and the command which is run.
  },
  keys = {
    { "<leader>cc", ":Gen Chat<CR>", desc = "Chat", mode = "n" },
    { "<leader>cC", ":Gen Change_Code<CR>", desc = "Change Code", mode = "v" },
    { "<leader>cR", ":Gen Review_Code<CR>", desc = "Review Code", mode = "v" },
    { "<leader>cg", ":Gen Enhance_Grammar_Spelling<CR>", desc = "Enhance Grammar", mode = "v" },
    { "<leader>cw", ":Gen Enhance_Wording<CR>", desc = "Enhance Wording", mode = "v" },
    { "<leader>cA", ":Gen Ask<CR>", desc = "Ask text", mode = "v" },
    { "<leader>ce", ":Gen Enhance_Prompt<CR>", desc = "Enhance with prompt", mode = "v" },
  },
}
