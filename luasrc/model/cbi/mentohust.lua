--[[

LuCI mentohust
Author:a1ive

]]--

require("luci.tools.webadmin")

m = Map("mentohust", translate("MentoHUST"), translate("锐捷、赛尔认证客户端."))
function m.on_commit(self)
os.execute("/etc/init.d/mentohust start")
end

s = m:section(TypedSection, "option", translate("启动选项"),translate("设置mentohust启动选项"))
s.anonymous = true

s:option(Flag, "enable", translate("启用MentoHUST"), translate("启用或禁用mentohust")).default="0"

s:option(Flag, "boot", translate("开机自启"), translate("开机时自动启动mentohust")).default="0"


s = m:section(TypedSection, "mentohust", translate("设置mentohust"),translate("以下选项为mentohust的参数"))
s.anonymous = true

s:option(Value, "Username", translate("Username")).default="hust"

pw=s:option(Value, "Password", translate("Password"))
pw.password = true
pw.rmempty = false
pw.default= "test"

nic=s:option(ListValue, "Nic", translate("网卡"))
nic.anonymous = true
for k, v in pairs(luci.sys.net.devices()) do
	nic:value(v)
end


s:option(Value, "IP", translate("IP"),translate("默认IP")).default="0.0.0.0"

s:option(Value, "Mask", translate("子网掩码"),translate("默认子网掩码")).default="255.255.255.0"

s:option(Value, "Gateway", translate("网关"),translate("默认为 0.0.0.0")).default="0.0.0.0"

s:option(Value, "DNS", translate("DNS"),translate("默认为 0.0.0.0")).default="0.0.0.0"

s:option(Value, "PingHost", translate("Ping主机"),translate("默认0.0.0.0，表示关闭该功能")).default="0.0.0.0"

s:option(Value, "Timeout", translate("认证超时"),translate("默认为 8s")).default="8"

s:option(Value, "EchoInterval", translate("心跳间隔"),translate("默认为 30s")).default="30"

s:option(Value, "RestartWait", translate("失败等待"),translate("默认为 15s")).default="15"

s:option(Value, "MaxFail", translate("允许失败次数"),translate("0表示无限制，默认8")).default="8"

t=s:option(ListValue, "StartMode", translate("组播地址"),translate("默认为 0"))
t:value("0", translate("0(标准)"))
t:value("1", translate("1(锐捷)"))
t:value("2", translate("2(赛尔)"))
t.default = "0"

t= s:option(ListValue, "DhcpMode", translate("DHCP方式"),translate("默认为 0"))
t:value("0", translate("0(不使用)"))
t:value("1", translate("1(二次认证)"))
t:value("2", translate("2(认证后)"))
t:value("3", translate("3(认证前)"))
t.default = "0"

t=s:option(ListValue, "DaemonMode", translate("是否后台运行"),translate("默认为 1"))
t:value("1", translate("1(是，关闭输出)"))
t:value("2", translate("2(是，保留输出)"))
t:value("3", translate("3(是，输出到文件)"))
t.default = "1"

s:option(Value, "Version", translate("客户端版本号"),translate("默认0.00表示兼容xrgsu")).default="0.00"

s:option(Value, "DataFile", translate("自定义数据文件"),translate("默认不使用")).default="/etc/mentohust"

s:option(Value, "dhcpscript", translate("DHCP脚本"),translate("默认dhclient")).default="udhcpc -i"


return m
