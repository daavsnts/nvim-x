return {
	"stevearc/conform.nvim",
	config = function()
		local conform = require("conform")
		local util = require("lspconfig.util")

		local function has_any_file_in_root(root, filenames)
			if not root then
				return false
			end
			for _, filename in ipairs(filenames) do
				if vim.fn.filereadable(root .. "/" .. filename) == 1 then
					return true
				end
			end
			return false
		end

		local function has_eslintrc(ctx)
			if not ctx or not ctx.filename then
				return false
			end
			local root =
				util.root_pattern("eslint.config.js", ".eslintrc", ".eslintrc.js", ".eslintrc.json")(ctx.filename)
			return has_any_file_in_root(root, {
				"eslint.config.js",
				".eslintrc",
				".eslintrc.js",
				".eslintrc.json",
			})
		end

		local function has_biomerc(ctx)
			if not ctx or not ctx.filename then
				return false
			end
			local root = util.root_pattern("biome.json", "biome.yaml", "biome.yml")(ctx.filename)
			return has_any_file_in_root(root, {
				"biome.json",
				"biome.yaml",
				"biome.yml",
			})
		end

		conform.setup({
			formatters_by_ft = {
				javascript = { "eslint_d", "biome" },
				javascriptreact = { "eslint_d", "biome" },
				typescript = { "eslint_d", "biome" },
				typescriptreact = { "eslint_d", "biome" },
        javascriptvue = { "eslint_d", "biome" },
        typescriptvue = { "eslint_d", "biome" },
				lua = { "stylua" },
			},
			formatters = {
				eslint_d = {
					condition = function(_, ctx)
						return has_eslintrc(ctx) and not has_biomerc(ctx)
					end,
				},
				biome = {
					condition = function(_, ctx)
						local defaultConditions = has_biomerc(ctx) and not has_eslintrc(ctx)
						local noneConditions = not has_biomerc(ctx) and not has_eslintrc(ctx)
						return defaultConditions or noneConditions
					end,
				},
			},
		})
	end,
}
