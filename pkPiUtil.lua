local version="1.0"
local releaseDate="8-6-2019"
local readme="8-6-2019 1.0 Origional PiCalc release"
local function fnADCcalc(Ad,Vs,Ro,Re)
  --fnThermResistance(1880,3.3,10000,4095)
  --Calculate ADA Reading or Analog Voltage
  --Resolution of the ADC / System Voltage = ADC Reading / Analog Voltage Measured

  --Resolution of ADC / System Voltage * Analog Voltage Measured = ADC Reading
  --System Voltage / Resolution of ADC * ADC Reading = Analog Voltage Measured
  --3.3 / 4095 (.0008089) * 2055 = 1.66 vdc with nothing attached
  --Ad = 1880 -- Need to feed this from GPIO, ADC Value
  --Vo = Calculated ADC Voltage
  --Vs = 3.3 -- Static Source Voltage
  --Rt = Calculated Thermister Resistance
  --Ro = 10000 -- Static Reference Resistor Resistance
  --Re = 4095 -- Static Resolution of ADC
  --Tp = Calculated Temperature from Thermistor Table
  Vo=Vs/Re*Ad -- Calculated ADC Voltage
  Rt = Ro * (( Vs / Vo ) - 1)  -- Caculated Thermistor Resistance
  Rt2 = Ro * ((Re / Ad) - 1) -- Calculate Thermistor Resistance if Vs and ADC Source Voltage the Same Then THis Works
  return Rt,Vo
end
local function fnThermLookup(table, number)
  -- this works but needs cleaning up and add a scale between the numbers
  -- ISSUE getting nil on return when Ad is higher number like 1860 but not at 2047
  --nextSmaller, nextLarger, x = NearestValue(tbThermistors,Rt)
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
local function fnRelay(num,state)
  --fnOutput("8",1)
  if state==1 then
    os.execute("megaio 0 rwrite "..num.." on")
  elseif state==0 then
    os.execute("megaio 0 rwrite "..num.." off")
  end
end
local function fnIOStatus()
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
local function fnDegCtoF(c)
    return c * 9 / 5 + 32
end
local function fnSleep(n)  -- seconds
  local clock = os.clock  
  local t0 = clock()
  while clock() - t0 <= n do end
end
local tb10KType2={[237]=302,
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

pkPiUtil={
  version=version,
  releaseDate=releaseDate,
  readme=readme,
  fnADCcalc=fnADCcalc,
  fnThermLookup=fnThermLookup,
  fnRelay=fnRelay,
  fnIOStatus=fnIOStatus,
  fnDegCtoF=fnDegCtoF,
  fnSleep=fnSleep,
  tb10KType2=tb10KType2,  
}
print("pkPiUtil loaded")



