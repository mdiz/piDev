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
local tb10KType2OLD={[237]=302,
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
local tb10KType2={[232032]=-39,
[217394]=-37,
[203774]=-35,
[191093]=-33,
[179281]=-31,
[168275]=-29,
[158013]=-27,
[148442]=-25,
[139511]=-23,
[131100]=-21,
[123317]=-19,
[116045]=-17,
[109247]=-15,
[102889]=-13,
[96941]=-11,
[91374]=-9,
[86160]=-7,
[81276]=-5,
[76659]=-3,
[72371]=-1,
[68348]=1,
[64574]=3,
[61031]=5,
[57703]=7,
[54578]=9,
[51641]=11,
[48879]=13,
[46259]=15,
[43817]=17,
[41519]=19,
[39354]=21,
[37316]=23,
[35395]=25,
[33585]=27,
[31878]=29,
[30267]=31,
[28735]=33,
[27302]=35,
[25948]=37,
[24670]=39,
[23462]=41,
[22320]=43,
[21241]=45,
[20220]=47,
[19254]=49,
[18332]=51,
[17467]=53,
[16648]=55,
[15872]=57,
[15136]=59,
[14439]=61,
[13778]=63,
[13151]=65,
[12556]=67,
[11987]=69,
[11451]=71,
[10942]=73,
[10459]=75,
[10000]=77,
[9564]=79,
[9149]=81,
[8754]=83,
[8379]=85,
[8019]=87,
[7679]=89,
[7355]=91,
[7047]=93,
[6754]=95,
[6474]=97,
[6208]=99,
[5954]=101,
[5712]=103,
[5479]=105,
[5258]=107,
[5048]=109,
[4847]=111,
[4656]=113,
[4473]=115,
[4298]=117,
[4131]=119,
[3971]=121,
[3817]=123,
[3671]=125,
[3532]=127,
[3398]=129,
[3271]=131,
[3149]=133,
[3032]=135,
[2920]=137,
[2812]=139,
[2709]=141,
[2610]=143,
[2516]=145,
[2425]=147,
[2339]=149,
[2256]=151,
[2176]=153,
[2099]=155,
[2026]=157,
[1955]=159,
[1887]=161,
[1822]=163,
[1760]=165,
[1700]=167,
[1642]=169,
[1587]=171,
[1534]=173,
[1483]=175,
[1433]=177,
[1386]=179,
[1341]=181,
[1297]=183,
[1255]=185,
[1214]=187,}

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



