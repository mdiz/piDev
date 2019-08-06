--[[
https://github.com/mdiz/piDev.git

Recommended Settings for Windows For this book, the following environment variables are recommended on Windows systems: 

UTIL_DIR=c:\program files\utility 
LUA_DIR=c:\program files\lua\5.1 
LUA_CPATH=?.dll;%LUA_DIR%\?.dll 
LUA_PATH=?.lua;%LUA_DIR%\?.lua 



The UTIL_DIR variable identifies the utility directory you created in the preceding section. Additionally, 
if you have a software development kit and intend to compile Lua and possibly libraries for Lua, set the 
following environment variables: 

SDK_DIR=c:\program files\msc 
INCLUDE=%SDK_DIR%\include;%SDK_DIR%\include\usr 
LIB=%SDK_DIR%\lib;%SDK_DIR%\lib\usr

--prints the lua package paths from the table package
print("LUA MODULES:\n",(package.path:gsub("%;","\n\t")),"\n\nC MODULES:\n",(package.cpath:gsub("%;","\n\t")))


--]]


--x=loadfile("pkServers.lua")
--x()
--dofile("servers.lua")
--x=dofile("c:\Users\Mike Dismore\Dropbox (Voyant Solutions)\XVS Development\Development Versions\Unified Controller\DEV\servers.lua")
--x=dofile("C:\\Users\\Public\\servers.lua")
--x=dofile([[C:\Users\Public\servers.lua]])
--dofile([[c:\path\lib1.lua]])
--pkServers.fnSetServer()
--fnServers=loadfile("servers.lua")
--fnServers()
--print(servers)
--servers.fnSetServer(4)c:\
--x=dofile([[/data/servers.lua]])
--dofile("c:\\Users\\Mike Dismore\\Dropbox (Voyant Solutions)\\XVS Development\\Development Versions\\Unified Controller\\DEV\\LuaTest.lua")

--print(tbObjARC2.tbAI2.PointName)


--{"path": "\\data\\.","size": 0,"attr": 67,"date": "2017-09-14 21:11:54" }, 
--{"path": "\\data\\..","size": 0,"attr": 67,"date": "2017-09-14 21:11:54" }, 
--{"path": "\\data\\trend.csv","size": 53,"attr": 3,"date": "2000-01-02 19:11:30" }, 
--{"path": "\\data\\servers.lua","size": 1171,"attr": 3,"date": "2000-01-02 19:26:28" }, 
--{"path": "\\data\\Config ARC Tool.xlsm","size": 438963,"attr": 3,"date": "2017-07-15 19:25:20" }, 
--{"path": "\\data\\Schedule Calculator.xlsx","size": 10765,"attr": 3,"date": "2016-02-02 23:10:26" }


--set LUA_PATH=?.lua;C:\Program Files\lua\5.1\?.lua;C:\Users\Mike Dismore\Dropbox (Voyant Solutions)\XVS Development\Development Versions\Unified Controller\DEV\?.lua

--[[

os functions
difftime function: 217C3918
remove function: 217C3958
move function: 217C39B8
clock function: 217C3898
time function: 217C39F8
rename function: 217C3978
date function: 217C38D8

io functions
lines function: 217C33E0
write function: 217C3500
close function: 217C3360
flush function: 217C3380
open function: 217C3400
output function: 217C3440
read function: 217C34C0
stderr file (closed)
stdin file (closed)
input function: 217C33A0
stdout file (closed)
type function: 217C34E0
popen function: 217C3480


--]]


-- Need this in a function to create appklpkcation object tables.  Should all the application tables be one table? YES
-- Review master object table to decide how to use SYSTEM and HARDWARE objects
-- Add fields to identify the application (ARC1, ARC2...). This could be done by adding (ARC1, ARC2 to the table name) (tbAV24 is now ARC1_V24)
--dofile("pkUtil.lua")
--Util=loadfile("ssspkUtil.lua")

--dofile("obj.lua")
-- Build this into a single function that builds the string and saves it as a table

--pkUtil.fnCopyTableToFile(tbObj,"TestTable","TestTable.lua","a")

--dofile("TestTable.lua")


--"r" read mode (the default);
--"w" write mode;
--"a" append mode;
--"r+" update mode, all previous data is preserved;
--"w+" update mode, all previous data is erased;
--"a+" append update mode, previous data is preserved, writing is only allowed at the end of file.
--[[

    function serializeOld (o) -- this works
      if type(o) == "number" then
        io.write(o)
      elseif type(o) == "string" then
        io.write(string.format("%q", o))
      elseif type(o) == "table" then
        io.write("{\n")
        for k,v in pairs(o) do
          io.write("  ", k, " = ")
          serialize(v)
          io.write(",\n")
        end
        io.write("}\n")
      else
        error("cannot serialize a " .. type(o))
      end
    end

    function serialize2 (o) -- this works, add brackets
      if type(o) == "number" then
        io.write(o)
      elseif type(o) == "string" then
        io.write(string.format("%q", o))
      elseif type(o) == "table" then
        io.write("{\n")
        for k,v in pairs(o) do
          --io.write("  ", k, " = ")
          io.write("  [")
          serialize(k)
          io.write("] = ")

          serialize(v)
          io.write(",\n")
        end
        io.write("}\n")
      else
        error("cannot serialize a " .. type(o))
      end
    end

    function serialize3 (o) -- changed to build into one line
      -- Save Lua table as file that can be loaded back into program
      if type(o) == "number" then
        io.write(o)
      elseif type(o) == "string" then
        io.write(string.format("%q", o))
      elseif type(o) == "table" then
        --io.write("{\n")
        io.write("{")
        for k,v in pairs(o) do
          --io.write("  ", k, " = ")
          io.write("[")
          serialize(k)
          io.write("]=")

          serialize(v)
          --io.write(",\n")
          io.write(",")
        end
        io.write("}\n")
        --io.write("}")
      else
        error("cannot serialize a " .. type(o))
      end
    end

    function serializeNOPE (o) -- changed to build into one line
      -- Save Lua table as file that can be loaded back into program
      --local lvTable
      if type(o) == "number" then
        lvTable=lvTable..o
      elseif type(o) == "string" then
        lvTable=lvTable..string.format("%q", o)
      elseif type(o) == "table" then
        --io.write("{\n")
        lvTable="{"
        for k,v in pairs(o) do
          --io.write("  ", k, " = ")
          lvTable=lvTable.."  ["
          serialize(k)
          lvTable=lvTable.."] = "

          serialize(v)
          --io.write(",\n")
          lvTable=lvTable..","
        end
        lvTable=lvTable.."}\n"
        --io.write("}")
      else
        error("cannot serialize a " .. type(o))
      end
      --print(lvTable)
    end


     function fnSerializeWorking (lvTable) -- changed to build into a file
      -- Save Lua table as file that can be loaded back into program
      if type(lvTable) == "number" then
        lvCovLog:write(lvTable)
      elseif type(lvTable) == "string" then
        lvCovLog:write(string.format("%q", lvTable))
      elseif type(lvTable) == "table" then
        --io.write("{\n")
        lvCovLog:write("={")
        for k,v in pairs(lvTable) do
          --io.write("  ", k, " = ")
          lvCovLog:write("[")
          fnSerialize(k)
          lvCovLog:write("]=")

          fnSerialize(v)
          --io.write(
          lvCovLog:write(",")
        end
        lvCovLog:write("}\n")
        --io.write("}")
      else
        error("cannot serialize a " .. type(lvTable))
      end
    end
  function fnObjSave(lvTable,lvFile, lvTableName)
    lvCovLog = io.open(lvFile, "w+")
    lvCovLog:write(lvTableName)
    fnSerialize(lvTable)
    lvCovLog:close()
  end



--three file types - .opr  .bak  .upd


-- UPDATE need log file to write to with io.write()




FirmwareOld="2.13.2.11"
FirmwareNew="2.20.1.4" 
ME.CFG1_Firmware_Version.value
--]]

--[[
do
local clock = os.clock
function sleep(n)  -- seconds
  local t0 = clock()
  while clock() - t0 <= n do end
end
  os.execute("megaio 0 rwrite 1 on")
  sleep(1)
  os.execute("megaio 0 rwrite 2 on")
  sleep(1)
  os.execute("megaio 0 rwrite 3 on")
  sleep(1)
  os.execute("megaio 0 rwrite 4 on")
  sleep(1)
  os.execute("megaio 0 rwrite 5 on")
  sleep(1)
  os.execute("megaio 0 rwrite 6 on")
  sleep(1)
  os.execute("megaio 0 rwrite 7 on")
  sleep(1)
  os.execute("megaio 0 rwrite 8 on")
  sleep(1)

  os.execute("megaio 0 rwrite 1 off")
  sleep(1)
  os.execute("megaio 0 rwrite 2 off")
  sleep(1)
  os.execute("megaio 0 rwrite 3 off")
  sleep(1)
  os.execute("megaio 0 rwrite 4 off")
  sleep(1)
  os.execute("megaio 0 rwrite 5 off")
  sleep(1)
  os.execute("megaio 0 rwrite 6 off")
  sleep(1)
  os.execute("megaio 0 rwrite 7 off")
  sleep(1)
  os.execute("megaio 0 rwrite 8 off")
end

function fnOutput(num,state)
  if state==1 then
    os.execute("megaio 0 rwrite "..num.." on")
  elseif state==0 then
    os.execute("megaio 0 rwrite "..num.." off")
  end
end

fnOutput("8",1)

--megaio 0 rwrite 1 on
--megaio 0 rread 1

--megaio 0 aread 1

vTemp1=os.execute("megaio 0 aread 1")
print(vTemp1)


local handle = io.popen(command)
local result = handle:read("*a")
handle:close()


handle=io.popen(os.execute("megaio 0 aread 1"),"r")
vTemp1 = handle:read("*a")
handle:close()



function os.capture(cmd, raw)
  local f = assert(io.popen(cmd, 'r'))
  local s = assert(f:read('*a'))
  f:close()
  if raw then return s end
  s = string.gsub(s, '^%s+', '')
  s = string.gsub(s, '%s+$', '')
  s = string.gsub(s, '[\n\r]+', ' ')
  return s
end

vTemp1=os.capture(os.execute("megaio 0 aread 1"))

--]]

local function toFahrenheit(c)
    return c * 9 / 5 + 32
end

VCC = 3.3   -- NodeMCU on board 3.3v vcc
--VCC = 5   -- NodeMCU on board 5v vcc
R2 = 10000  -- 10k ohm series resistor
--adc_resolution = 1023 -- 10-bit adc
adc_resolution = 4095 -- 12-bit adc

-- thermistor equation parameters
A = 0.001129148 
B = 0.000234125
C = 8.76741*10^-8 

function ln(x)      --natural logarithm function for x>0 real values
    local y = (x-1)/(x+1)
    local sum = 1 
    local val = 1
    if(x == nil) then
        return 0
    end
-- we are using limited iterations to acquire reliable accuracy.
-- here its upto 10000 and increased by 2
    for i = 3, 10000, 2 do
        val = val*(y*y)
        sum = sum + (val/i)
    end
    return 2*y*sum
end

--while true do
    local Vout, Rth, temperature
    --local adc_value = adc.read(0)
    local adc_value=2013
    Vout = (adc_value * VCC) / adc_resolution
    Rth = (VCC * R2 / Vout) - R2
    temperature = (1 / (A + (B * ln(Rth)) + (C * (ln(Rth))^3)))   -- Temperature in kelvin
    temperature = temperature - 273.15  -- Temperature in degree celsius
    temperatureF=toFahrenheit(temperature)
    print(string.format("Temperature = %0.3g °C",temperature))
    print(string.format("Temperature = %0.3g °F",temperatureF))
    --tmr.delay(100000)
--end
-- 2030 = 78.4
-- 1990 = 77
-- 1900 = 74
-- 1300 = 53.4
-- 2055 = nothing attached
-- 2955 = 10k resistor only
-- 2955 = 5vdc only
-- 4095 = 3vdc only

--Vout = VCC * ADC_Value / ADC_Resolution
Vout=((5*1990)/0.00122)
print("Vout = "..Vout)


-- Calculate ADA Reading or Analog Voltage
--Resolution of the ADC / System Voltage = ADC Reading / Analog Voltage Measured

--Resolution of ADC / System Voltage * Analog Voltage Measured = ADC Reading
--System Voltage / Resolution of ADC * ADC Reading = Analog Voltage Measured
--3.3 / 4095 (.0008089) * 2055 = 1.66 vdc with nothing attached


--adcMax / adcVal = Vs / Vo 
--That is, the ratio of voltage divider input voltage to output voltage is the same as the ratio of the ADC full range 
--value (adcMax) to the value returned by the ADC (adcVal). If you are using a 10 bit ADC then adcMax is 1023.


--Ad = ADC Value
--Vo = ADC Voltage
--Vs = Source Voltage
--Rt = Thermister Resistance
--Ro = Reference Resistor Resistance
--Re = Resolution of ADC

-- 2047 ADC reading is 10k Thermistor Resistance
Ad = 1880 -- Need to feed this from GPIO, ADC Value
--Vo = Calculated ADC Voltage
Vs = 3.3 -- Static Source Voltage
--Rt = Calculated Thermister Resistance
Ro = 10000 -- Static Reference Resistor Resistance
Re = 4095 -- Static Resolution of ADC
Vo=Vs/Re*Ad -- Calculated ADC Voltage
Rt = Ro * (( Vs / Vo ) - 1)  -- Caculated Thermistor Resistance
--Tp = Calculated Temperature from Thermistor Table
print("Resistance = "..Rt)

Rt2 = Ro * ((Re / Ad) - 1) -- Calculate Thermistor Resistance if Vs and ADC Source Voltage the Same Then THis Works
print("Resistance 2 = "..Rt2)

do
  local clock = os.clock
  function sleep(n)  -- seconds
    local t0 = clock()
    while clock() - t0 <= n do end
  end
  while true do
    os.execute("megaio 0 aread 1")
    sleep(1)
  end
end

tbThermistors={[237]=302,
[265.1]=293,
[297.2]=284,
[334]=275,
[376.4]=266,
[425.3]=257,
[481.8]=248,
[547.3]=239,
[623.6]=230,
[712.6]=221,
[816.8]=212,
[939.3]=203,
[1084]=194,
[1255]=185,
[1458]=176,
[1700]=167,
[1990]=158,
[2339]=149,
[2760]=140,
[3271]=131,
[3893]=122,
[4655]=113,
[5592]=104,
[6752]=95,
[8194]=86,
[10000]=77,
[12263]=68,
[15130]=59,
[18780]=50,
[23457]=41,
[29490]=32,
[37313]=23,
[47543]=14,
[61020]=5,
[78913]=-4,
[102861]=-13,
[135185]=-22,
[179200]=-31,
[239686]=-40,}


do
  local lvLower
  for i,v in pairs(tbThermistors) do
    if lvLower==nil then lvLower=i print("first lower = "..lvLower) end
    if i<=lvLower then
      lvLower=i
    end
  end
  print("lowest value = "..lvLower)
end







--Rt=333
--297.2
--334
--376.4
-- this works but needs cleaning up and add a scale between the numbers
-- ISSUE getting nil on return when Ad is higher number like 1860 but not at 2047
function NearestValue(table, number)
    local smallestSoFar, smallestIndex, nextLarger, nextLargerIndex,nextSmaller, nextSmallerIndex
    for i, y in pairs(table) do -- Find the closest resistance to number
        --if not smallestSoFar or (math.abs(number-i) < smallestSoFar) then
        if not smallestSoFar or (math.abs(number-i) < smallestSoFar) then
            smallestSoFar = math.abs(number-i)
            smallestIndex = i
        end
    end
    for i, y in pairs(table) do -- find the next larger resistance to number
      --if not smallestSoFar or (math.abs(number-i) < smallestSoFar) then
      if not nextLarger or (math.abs(smallestIndex-i) < nextLarger) and i>smallestIndex and i~=smallestIndex then
          nextLarger = math.abs(smallestIndex-i)
          nextLargerIndex = i
      end
    end
    for i, y in pairs(table) do -- find the next smaller resistance to number
      --if not smallestSoFar or (math.abs(number-i) < smallestSoFar) then
      if not nextSmaller or (math.abs(smallestIndex-i) < nextSmaller) and i<smallestIndex and i~=smallestIndex then
          nextSmaller = math.abs(smallestIndex-i)
          nextSmallerIndex = i
      end
    end
    -- decide what resistance values number is between
    if number>=nextSmallerIndex and number<=smallestIndex then 
      lowRange=nextSmallerIndex
      HighRange=smallestIndex
    elseif number>=smallestIndex and number<=nextLargerIndex then
      lowRange=smallestIndex
      HighRange=nextLargerIndex
    end




    return lowRange, HighRange, smallestIndex
end

nextSmaller, nextLarger, x = NearestValue(tbThermistors,Rt)

print(nextSmaller)
print(nextLarger)
print(tbThermistors[x])


function fnIO()
  print("****Relay Outputs****")
  os.execute("megaio 0 rread 1") -- Relay Output
  os.execute("megaio 0 rread 2")
  os.execute("megaio 0 rread 3")
  os.execute("megaio 0 rread 4")
  os.execute("megaio 0 rread 5")
  os.execute("megaio 0 rread 6")
  os.execute("megaio 0 rread 7")
  os.execute("megaio 0 rread 8")

  print("****ADC Inputs****") -- megaio <id> test-dac-adc <adcCh>
  os.execute("megaio 0 aread 1") -- ADC Input
  os.execute("megaio 0 aread 2")
  os.execute("megaio 0 aread 3")
  os.execute("megaio 0 aread 4")
  os.execute("megaio 0 aread 5")
  os.execute("megaio 0 aread 6")
  os.execute("megaio 0 aread 7")
  os.execute("megaio 0 aread 8")

  print("****OPTO Inputs****") -- megaio <id> test-opto-oc <optoCh> <ocCh>
  os.execute("megaio 0 optread 1") -- OPTO Input
  os.execute("megaio 0 optread 2")
  os.execute("megaio 0 optread 3")
  os.execute("megaio 0 optread 4")
  os.execute("megaio 0 optread 5")
  os.execute("megaio 0 optread 6")
  os.execute("megaio 0 optread 7")
  os.execute("megaio 0 optread 8")

  print("****Open Collector Outputs****")
  os.execute("megaio 0 ocread 1") -- Open Collector Output
  os.execute("megaio 0 ocread 2")
  os.execute("megaio 0 ocread 3")
  os.execute("megaio 0 ocread 4")

  print("****IO Pin****") -- megaio <id> test-io <ch1> <ch2>
  os.execute("megaio 0 iodread 1") -- IO Pin
  os.execute("megaio 0 iodread 2")
  os.execute("megaio 0 iodread 3")
  os.execute("megaio 0 iodread 4")
  os.execute("megaio 0 iodread 5")
  os.execute("megaio 0 iodread 6")

  print("****IO Pin****")
  os.execute("megaio 0 ioread 1") -- IO Pin
  os.execute("megaio 0 ioread 2")
  os.execute("megaio 0 ioread 3")
  os.execute("megaio 0 ioread 4")
  os.execute("megaio 0 ioread 5")
  os.execute("megaio 0 ioread 6")
end



megaio 0 ocwrite 1 on
megaio <id> ocwrite <ch> <on/off; 1/0>
os.execute("megaio 0 ocwrite 1 on")



         megaio -v
         megaio -lt
         megaio -lw <val>
         megaio -lw <lednr> <val>
         megaio -warranty
         megaio -connector
         megaio <id> board
        
         megaio <id> rwrite <channel> <on/off>
         megaio <id> rread <channel>
         megaio <id> rread
        
         megaio <id> aread <channel>
         megaio <id> awrite <value>
        
         megaio <id> optread <channel>
         megaio <id> optread
        
         megaio <id> ocread
         megaio <id> ocwrite <ch> <on/off; 1/0>
         megaio <id> ocwrite <val>
        
         megaio <id> optirqset <channel> <rising/falling/change/none>
         megaio <id> optitRead
        
         megaio <id> iodwrite <channel> <in/out> -- For setting type of IO
         megaio <id> iodread <channel>
         megaio <id> iodread
        
         megaio <id> iowrite <channel> <on/off> -- For reading the IO
         megaio <id> ioread <channel>
         megaio <id> ioread
        
         megaio <id> ioirqset <channel> <rising/falling/change/none>
         megaio <id> ioitread
        
         --megaio <id> test
         megaio <id> atest <chNr>
         --megaio <id> test-opto-oc <optoCh> <ocCh>
         --megaio <id> test-io <ch1> <ch2>
         --megaio <id> test-dac-adc <adcCh>
