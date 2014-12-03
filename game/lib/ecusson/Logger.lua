-----------------------------------------------------------------------------------------
--
-- Author: Aurélien Defossez
-- (c) 2014 Tabemasu Games (www.tabemasu.com)
--
-- Logger.lua
--
-- A logger logging the prints into a file, which can be sent by email
--
-----------------------------------------------------------------------------------------

local Class = {}

-----------------------------------------------------------------------------------------
-- Local configuration
-----------------------------------------------------------------------------------------

local memoryWarningMinGarbageInterval = 15.0

-----------------------------------------------------------------------------------------
-- Initialization and Destruction
-----------------------------------------------------------------------------------------

-- Create the logger
--
-- Parameters:
--  bugReportMail: The email address to send bug reports to
--  bugReportName: The log file name
--  screenshotName: The screenshot file name
function Class.create(options)
	local self = {}
	setmetatable(self, {
		__index = Class
	})

	-- Initialize attributes
	self.bugReportMail = options.bugReportMail
	self.bugReportName = options.bugReportName
	self.screenshotName = options.screenshotName
	self.filePath = system.pathForFile(self.bugReportName, system.DocumentsDirectory)
	self.oldPrint = print
	self.lastMemoryWarning = 0
	self.screenshot = false
	self.bugCaught = false
	self.lines = {}
	self.bugReportPopupTitle = "The game crashed"
	self.bugReportPopupContent = "Would you like to send a bug report to the developer?"
	self.bugReportMailTitle = "Bug report"
	self.bugReportMailBody = ""
	self.yes = "Yes"
	self.no = "No"

	-- Reset log file
	io.close(io.open(self.filePath, "w"))

	-- Override print method to write into file
	print = function(...)
		self.oldPrint(unpack(arg))

		local line = ""
		for key, value in ipairs(arg) do
			line = line.." "..tostring(value)
		end

		self.lines[#self.lines + 1] = line
	end

	-- Bind events
	Runtime:addEventListener("memoryWarning", self)
	Runtime:addEventListener("unhandledError", self)

	return self
end

-- Destroy the logger
function Class:destroy()
	Runtime:removeEventListener("memoryWarning", self)
	Runtime:removeEventListener("unhandledError", self)

	print = self.oldPrint

	self = {}
end

-----------------------------------------------------------------------------------------
-- Methods
-----------------------------------------------------------------------------------------

function Class:setTexts(options)
	self.bugReportPopupTitle = options.popupTitle
	self.bugReportPopupContent = options.popupContent
	self.bugReportMailTitle = options.mailTitle
	self.bugReportMailBody = options.mailBody
	self.yes = options.yes
	self.no = options.no
end

-- Write all buffer in file
function Class:writeFile()
	local fh = io.open(self.filePath, "a")

	for key, line in ipairs(self.lines) do
		fh:write(line.."\n")
	end

	self.lines = {}

	io.close(fh)
end

-- Take a screenshot of the scene
function Class:takeScreenshot()
	display.save(display.currentStage, self.screenshotName)
	self.screenshot = true
end

-- Send an email to the developer
function Class:sendEmail()
	self:writeFile()

	-- Prepare log attachment
	local attachments = {
		{
			baseDir = system.DocumentsDirectory,
			filename = self.bugReportName,
			type = "text"
		}
	}

	-- Prepare screenshot attachment if any
	if self.screenshot then
		attachments[#attachments + 1] = {
			baseDir = system.DocumentsDirectory,
			filename = self.screenshotName,
			type = "image"
		}

		self.screenshot = false
	end

	-- Prompt the user to send a mail
	native.showPopup("mail", {
		to = self.bugReportMail,
		subject = self.bugReportMailTitle,
		body = self.bugReportMailBody,
		attachment = attachments
	})
end

-----------------------------------------------------------------------------------------
-- Event listeners
-----------------------------------------------------------------------------------------

-- Unhandled error handler, which will automatically take a screenshot and send an email
function Class:unhandledError(event)
	if not self.bugCaught then
		self.bugCaught = true
		
		print(" ")
		print(" ")
		print("[Warning] *X*X*X*X*X*X*X*X*X*X*X*X*X*")
		print("[Warning] *X*                     *X*")
		print("[Warning] *X*   Unhandled  Error  *X*")
		print("[Warning] *X*                     *X*")
		print("[Warning] *X*X*X*X*X*X*X*X*X*X*X*X*X*")
		print(" ")
		print(event.errorMessage)
		print(" ")
		print(event.stackTrace)
		print(" ")

		if system.getInfo("environment") == "device" then
			print("[Logger] Take screenshot")
			self:takeScreenshot()

			print("[Logger] Pause game")
			local status, err = pcall(function(options)
				Runtime:dispatchEvent{
					name = "requirePause",
					status = true
				}
			end)

			if not status then
				print("[Logger] Error while pausing game", err)
			end

			print("[Logger] Ask to send mail")
			native.showAlert(self.bugReportPopupTitle, self.bugReportPopupContent, { self.no, self.yes }, function(event)
				self.bugCaught = false

				if event.action == "clicked" and event.index == 2 then
					print("[Logger] Send mail")
					self:sendEmail()
				end
			end)
		else
			print("[Logger] Cannot send mail from simulator")
			self.bugCaught = false
		end
	end
end

-- Memory warning handler, which will only print an error and the memory in the log
function Class:memoryWarning(event)
	print("[Warning] *X*X*X*X*X*X*X*X*X*X*X*X*")
	print("[Warning] *X*                   *X*")
	print("[Warning] *X*  Memory  Warning  *X*")
	print("[Warning] *X*                   *X*")
	print("[Warning] *X*X*X*X*X*X*X*X*X*X*X*X*")

	local time = utils.getTime()
	if time > self.lastMemoryWarning + memoryWarningMinGarbageInterval then
		print("[Memory Warning] Collect garbage")
		Sound.purgeSounds()
		collectgarbage("collect")
		self.lastMemoryWarning = time
	end

	if utils and utils.printMemory then
		utils.printMemory()
	else
		print("utils.printMemory not found")
	end
end

-----------------------------------------------------------------------------------------

return Class
