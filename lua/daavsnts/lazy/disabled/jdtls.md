local share_path = "/Users/daavsnts/.local/share"
local jdtls_path = share_path .. "/jdtls"
local lombok_path = share_path .. "/lombok/lombok.jar"
local jdtls_config = jdtls_path .. "/plugins/config/"
local equinox_launcher = jdtls_path .. "/plugins/org.eclipse.equinox.launcher_1.7.0.v20250331-1702.jar"
local java_path = "/Library/Java/JavaVirtualMachines/jdk-21.jdk/Contents/Home/bin/java"

return {
	{
		"mfussenegger/nvim-jdtls",
		ft = "java",
		config = function()
			local jdtls = require("jdtls")

			vim.api.nvim_create_autocmd("FileType", {
				pattern = "java",
				callback = function()
					if vim.b.jdtls_attached then
						return
					end
					vim.b.jdtls_attached = true

					local root_dir = vim.fs.dirname(vim.fs.find({
						"settings.gradle",
						"settings.gradle.kts",
						"pom.xml",
						"build.gradle",
						"mvnw",
						"gradlew",
					}, { upward = true })[1])
					if not root_dir then
						vim.notify("jdtls: root_dir not found", vim.log.levels.WARN)
						return
					end

					local project_name = vim.fn.fnamemodify(root_dir, ":p:h:t")
					local workspace_dir = vim.fn.stdpath("data") .. "/jdtls-workspaces/" .. project_name

					jdtls.start_or_attach({
						cmd = {
							java_path,
							"-Declipse.application=org.eclipse.jdt.ls.core.id1",
							"-Dosgi.bundles.defaultStartLevel=4",
							"-Declipse.product=org.eclipse.jdt.ls.core.product",
							"-Dosgi.checkConfiguration=true",
							"-Dosgi.sharedConfiguration.area=" .. jdtls_config,
							"-Dosgi.sharedConfiguration.area.readOnly=true",
							"-Dosgi.configuration.cascaded=true",
							"-Xms1G",
							"--add-modules=ALL-SYSTEM",
							"--add-opens",
							"java.base/java.util=ALL-UNNAMED",
							"--add-opens",
							"java.base/java.lang=ALL-UNNAMED",
							"-javaagent:" .. lombok_path,
							"-jar",
							equinox_launcher,
							"-configuration",
							jdtls_config,
							"-data",
							workspace_dir,
						},
						root_dir = root_dir,
						workspace_folder = workspace_dir,
					})
				end,
			})
		end,
	},
}
