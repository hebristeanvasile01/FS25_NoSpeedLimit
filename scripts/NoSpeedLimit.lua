-- FS25_NoSpeedLimit by FS Modding
-- 1) removes every <speedLimit> (tractors, implements, trailers, tools)
-- 2) full power: engine torque is multiplied so heavy tools no longer slow you down

NoSpeedLimit = {}
NoSpeedLimit.TORQUE_MULTIPLIER = 3.0   -- raise for even more pull, 1.0 = vanilla power

----------------------------------------------------------------------
-- 1) speed limit
----------------------------------------------------------------------
local function getSpeedLimit(self, superFunc, onlyIfWorking)
    local _, doCheck = superFunc(self, onlyIfWorking)
    self.speedLimit = math.huge
    return math.huge, doCheck
end

if Vehicle ~= nil and Vehicle.getSpeedLimit ~= nil then
    Vehicle.getSpeedLimit = Utils.overwrittenFunction(Vehicle.getSpeedLimit, getSpeedLimit)
    print("FS25_NoSpeedLimit: speed limits removed")
else
    print("FS25_NoSpeedLimit: Vehicle.getSpeedLimit not found, speed limit part inactive")
end

----------------------------------------------------------------------
-- 2) full power (torque curve of every motor)
----------------------------------------------------------------------
local scaled = {}

local function scaleMotor(motor)
    if motor == nil or type(motor) ~= "table" then
        return
    end
    local k = NoSpeedLimit.TORQUE_MULTIPLIER
    local curve = motor.torqueCurve
    if curve ~= nil and curve.keyframes ~= nil and not scaled[curve] then
        scaled[curve] = true
        for _, kf in ipairs(curve.keyframes) do
            if type(kf.v) == "number" then
                kf.v = kf.v * k
            elseif type(kf[1]) == "number" then
                kf[1] = kf[1] * k
            end
        end
        for _, field in ipairs({"peakMotorTorque", "maxMotorTorque", "peakMotorPowerKW"}) do
            if type(motor[field]) == "number" then
                motor[field] = motor[field] * k
            end
        end
    end
end

if VehicleMotor ~= nil and VehicleMotor.new ~= nil and NoSpeedLimit.TORQUE_MULTIPLIER ~= 1 then
    local origNew = VehicleMotor.new
    VehicleMotor.new = function(...)
        local motor = origNew(...)
        local ok, err = pcall(scaleMotor, motor)
        if not ok then
            print("FS25_NoSpeedLimit: torque scaling failed: " .. tostring(err))
        end
        return motor
    end
    print(string.format("FS25_NoSpeedLimit: full power active (x%.1f torque)", NoSpeedLimit.TORQUE_MULTIPLIER))
else
    print("FS25_NoSpeedLimit: VehicleMotor.new not found, full power part inactive")
end
