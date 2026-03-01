return {
	"stevearc/conform.nvim",
	config = function()
		local conform = require("conform")

		local eslint_files = {
			"eslint.config.js",
			"eslint.config.mjs",
			".eslintrc",
			".eslintrc.js",
			".eslintrc.json",
		}

		local biome_files = { "biome.json", "biome.yaml", "biome.yml" }

		local prettier_files = {
			".prettierrc",
			".prettierrc.json",
			".prettierrc.js",
			".prettierrc.cjs",
			"prettier.config.js",
			"prettier.config.cjs",
		}

		local function has_config(ctx, files)
			return ctx
				and ctx.filename
				and vim.fs.find(files, {
					upward = true,
					path = vim.fs.dirname(ctx.filename),
				})[1] ~= nil
		end

		local js_ts_formatters = { "eslint_d", "biome", "prettier" }

		conform.setup({
			formatters_by_ft = {
				html = { "prettier" },
				javascript = js_ts_formatters,
				javascriptreact = js_ts_formatters,
				typescript = js_ts_formatters,
				typescriptreact = js_ts_formatters,
				vue = js_ts_formatters,
				css = { "prettier" },
				json = { "jq" },
				markdown = { "prettier" },
				lua = { "stylua" },
				java = { "lsp" },
				htmlangular = { "prettier" },
				http = { "kulala-fmt" },
			},
			formatters = {
				eslint_d = {
					condition = function(_, ctx)
						return has_config(ctx, eslint_files)
					end,
				},
				biome = {
					condition = function(_, ctx)
						return has_config(ctx, biome_files)
					end,
				},
				prettier = {
					condition = function(_, ctx)
						return has_config(ctx, prettier_files)
					end,
				},
			},
		})
	end,
}
