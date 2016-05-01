--[[

LuCI mentohust
Author:a1ive

]]--

module("luci.controller.mentohust", package.seeall)

function index()

	if nixio.fs.access("/etc/config/mentohust") then
	local page 
	page = entry({"admin", "services", "mentohust"}, cbi("mentohust"), _("MentoHUST"), 30)
	page.i18n = "mentohust"
	page.dependent = true
	end
end
