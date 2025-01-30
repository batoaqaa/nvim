local M = {}

function M.handle_workspace_configuration(_, _, params)
	local config = require("kamaizen.config")
	return { config.config }
end

return M
