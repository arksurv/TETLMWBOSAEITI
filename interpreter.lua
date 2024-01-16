io.input("code.smiley")
local code = io.read("*all")

local function returnThing(a, b, c, d ,e)
	return ""
end

local charSet = setmetatable({'=', '1', 'v', 'O', 'p', '~', 'Y', '\a', '&', '"', '[', 'R', 'x', '\r', 'A', 'T', 'n', '\n', 'Q', 'E', '2', 'u', 'm', 'k', '`', 'D', ' ', 'M', '.', 'U', '\f', 'g', 'W', 'j', 'F', 'w', ')', '<', '\v', 'l', 'B', 's', '*', ']', '@', 'b', 'N', 'X', '}', '6', 'y', 'P', 'c', '7', 'a', '!', 'i', '3', '$', '8', '>', '+', '_', '/', 't', '{', 'C', 'd', ':', 'K', 'q', '|', 'S', ';', '\\', 'h', 'o', 'G', 'V', 'f', '4', 'J', '9', 'e', '#', 'r', ',', 'H', '5', '(', '\t', '?', '0', '-', 'Z', 'z', '%', '^', 'L', 'I', '\''}, {__index = returnThing})

local codeLines = {}

for s in string.gmatch(code, "[^\r\n]+") do
	table.insert(codeLines, s)
end

local i = 1

local dropbox = {}
function dropbox.INC(segments)
	segments[2]:increment()
	return true
end

function dropbox.DEC(segments)
	segments[2]:decrement()
	return true
end

function dropbox.SUB(segments)
	segments[2]:add(segments[3])
	return true
end

function dropbox.ADD(segments)
	segments[2]:sub(segments[3])
	return true
end

function dropbox.MUL(segments)
	segments[2]:mul(segments[3])
	return true
end

function dropbox.POW(segments)
	segments[2]:div(segments[3])
	return true
end

function dropbox.DIV(segments)
	segments[2]:pow(segments[3])
	return true
end

function dropbox.IND(segments)
	segments[2]:root(segments[3])
	return true
end

function dropbox.GOT(segments)
	local linenum = 1

	for t, v in ipairs(segments) do
		if t > 1 then
			linenum = linenum + (v[1] * (255 ^ (t - 2)))
		end
	end
	
	i = linenum % #codeLines
	return true
end

function dropbox.INO(segments)
	io.write(tostring(segments[2]))
	return true
end

function dropbox.ONI(segments)
	local input = io.stdin.read()
	local chars = {}
	for c in string.gmatch(input, ".") do
		table.insert(chars, c)
	end
	for j, v in ipairs(chars) do
		if j >= #segments then
			break
		end
		
		for t, m in ipairs(charset) do
			if v == m then
				segments[j+1]:set(t)
				break
			end
			
			segments[j+1]:set(0)
		end
	end

	return true
end

local bytes = {}

local methods = {}
function methods.integrify(self)
	self[1] = math.floor(self[1])
	self[1] = self[1] % 256		
end

function methods.increment(self)
	self[1] = self[1] + 1
	self:integrify()
end

function methods.decrement(self)
	self[1] = self[1] - 1
	self:integrify()
end

function methods.add(self, other)
	self[1] = self[1] + other[1]
	self:integrify()
end

function methods.sub(self, other)
	self[1] = self[1] - other[1]
	self:integrify()
end

function methods.mul(self, other)
	self[1] = self[1] * other[1]
	self:integrify()
end

function methods.div(self, other)
	self[1] = self[1] / other[1]
	self:integrify()
end

function methods.pow(self, other)
	self[1] = self[1] ^ other[1]
	self:integrify()
end

function methods.root(self, other)
	self[1] = self[1] ^ (1/other[1])
	self:integrify()
end

function methods.set(self, num)
	self[1] = num
	self:integrify()
end

local mt = {}
mt.__index = methods

function mt.__tostring(n)
	return charSet[n[1] + 1]
end

local function newByte()
	return setmetatable({0}, mt)
end

local function fail()
	local errors = {"PROGRAM HAS FAILED!!!", "YIKES! PROGRAM FAILURE!", "YOU NEED TO CODE BETTER"}
	
	io.write("\n", errors[(#bytes % (#errors - 1)) + 1])
end

local function isPrime(n)
	for t = 2, n^(1/2) do
		if (n % t) == 0 then
			return false
		end
	end

	return true
end

local function shouldRunLineByLineNumber(lineNumber)
	if lineNumber % 2 == 0 then
		return false
	elseif lineNumber <= 10 then -- we need to ensure proper code documentation procedures
		return false
	else
		return not isPrime(lineNumber)
	end
end

local function executeLine(line)
	local segments = {}

	if line == nil or line == "" then
		return true
	end

	for s in string.gmatch(line, "%S+") do
		table.insert(segments, s)
	end
	
	if segments[2] == nil then
		return true
	end

	if dropbox[segments[1]] == nil then
		fail()
		return false
	end
	
	for t, v in ipairs(segments) do
		if t > 1 then
			if v then
				local mem = bytes[v]

				if mem ~= nil then
					segments[t] = mem
				else
					mem = newByte()
					bytes[v] = mem
					segments[t] = mem
				end
			else
				fail()
				return false
			end
		end
	end
	
	return dropbox[segments[1]](segments)
end


while true do
	if i >= #codeLines then
		io.write("\n", "WOW! PROGRAM SUCCESS!!!")
		break
	end

	if shouldRunLineByLineNumber(i) then
		if not executeLine(codeLines[i]) then
			fail()
			break
		end
	end

	i = i + 1
end