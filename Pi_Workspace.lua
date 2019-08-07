--[[
https://github.com/mdiz/piDev.git -- gitHub clone URL

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

Push Files to git
1. On your computer, move the file you'd like to upload to GitHub into the local directory that was created when you cloned the repository.

2. Open Git Bash.

3. Change the current working directory to your local repository.

4. Stage the file for commit to your local repository.

$ git add .
# Adds the file to your local repository and stages it for commit. To unstage a file, use 'git reset HEAD YOUR-FILE'.

5. Commit the file that you've staged in your local repository.

$ git commit -m "Add existing file"
# Commits the tracked changes and prepares them to be pushed to a remote repository. To remove this commit and modify the file, use 'git reset --soft HEAD~1' and commit and add the file again.

6. Push the changes in your local repository to GitHub.

$ git push origin your-branch
# Pushes the changes in your local repository up to the remote repository you specified as

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
megaio 0 ocwrite 1 off

--]]


dofile("C:\\Users\\miked\\Dropbox (Voyant Solutions)\\XVS Development\\PiDev\\pkPiUtil.lua")



dist = function(t1, t2)
  return math.sqrt(((t1[1] - t2[1])^2) + ((t1[2] - t2[2])^2))
end


local function fnThermLookup(table, adcResistance,steps)
  --Calculate temp based resistance values.  Set steps to to balance between resolution and stability
  --vSpaceTemp,vSpaceTempResistance=fnThermLookup(pkPiUtil.tb10KType2, vAdcResistance,40)
  local lvSmaller, lvResistanceNearest, lvTempNearest
  for i,v in pairs(table) do -- Find the nearest resistance to adcResistance
      if not lvSmaller or (math.abs(adcResistance-i)<lvSmaller) then
          lvSmaller=math.abs(adcResistance-i)
          lvResistanceNearest=i
          lvTempNearest=v
      end
  end
  local lvNextLarger, lvResistanceLarger
  for i,v in pairs(table) do -- find the next larger resistance to adcResistance
    if not lvNextLarger or (math.abs(lvResistanceNearest-i)<lvNextLarger) and i>lvResistanceNearest and i~=lvResistanceNearest then
        lvNextLarger=math.abs(lvResistanceNearest-i)
        lvResistanceLarger=i
    end
  end
  local lvNextSmaller, lvResistanceSmaller
  for i,v in pairs(table) do -- find the next smaller resistance to adcResistance
    if not lvNextSmaller or (math.abs(lvResistanceNearest-i)<lvNextSmaller) and i<lvResistanceNearest and i~=lvResistanceNearest then
        lvNextSmaller=math.abs(lvResistanceNearest-i)
        lvResistanceSmaller=i
    end
  end
  -- decide what resistance values adcResistance is between
  local lvResistanceLow, lvResistanceHigh, lvTempLower, lvTempHigher
  if adcResistance>=lvResistanceSmaller and adcResistance<=lvResistanceNearest then 
    lvResistanceLow=lvResistanceSmaller
    lvResistanceHigh=lvResistanceNearest
    lvTempLow=table[lvResistanceHigh]
    lvTempHigh=table[lvResistanceLow]
  elseif adcResistance>=lvResistanceNearest and adcResistance<=lvResistanceLarger then
    lvResistanceLow=lvResistanceNearest
    lvResistanceHigh=lvResistanceLarger
    lvTempLow=table[lvResistanceHigh]
    lvTempHigh=table[lvResistanceLow]
  end
  -- Scale high and low resistance and temp to find temp within range of steps
  local lvResistanceDiff, lvTempDiff, lvResistanceStep, lvTempStep
  lvResistanceDiff=lvResistanceHigh-lvResistanceLow
  lvResistanceStep=lvResistanceDiff/steps
  lvTempDiff=lvTempLow-lvTempHigh
  lvTempStep=lvTempDiff/steps
  local tbRange={[lvResistanceHigh]=lvTempLow}
  local lvCurrentResistance=lvResistanceHigh
  local lvCurrentTemp=lvTempLow
  for s=1, steps do
    local i=lvCurrentResistance-lvResistanceStep
    local v=lvCurrentTemp-lvTempStep
    lvCurrentResistance=i
    lvCurrentTemp=v
    tbRange[i]=v
  end
  -- find nearest resistance to adcResistance within resistance subset table
  local lvSmaller, lvResistanceNearest, lvTempNearest
  for i,v in pairs(tbRange) do -- Find the nearest resistance to adcResistance
      if not lvSmaller or (math.abs(adcResistance-i)<lvSmaller) then
          lvSmaller=math.abs(adcResistance-i)
          lvResistanceNearest=i
          lvTempNearest=v
      end
  end
  return lvTempNearest,lvResistanceNearest
end

vAdcResistance,vAdcVoltage=pkPiUtil.fnADCcalc(1934,3.3,10000,4095)
vSpaceTemp,vSpaceTempResistance=fnThermLookup(pkPiUtil.tb10KType2, vAdcResistance,40)


print("vSpaceTemp = "..vSpaceTemp)
print("vSpaceTempResistance = "..vSpaceTempResistance)

--[[
This is how to calculate the exact temperature

--DiffR = Calculate difference between higher and lower resistance
--Lookup temp for higher resistance and lower resistance
--DiffT = Calculate difference between temperatures
Res = Divide resistance into 20 steps
Temp = Divide temp into 20 steps
Add Res , Temp to a local table
Use fnThermLookup to find nearest resistance from ADC and find on local table
--]]
