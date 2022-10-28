                                       -- เชื่อม Log Azael และ NC(ผ่านตัวแปลง) บน es_extended

                                        -- ไม่ต้องใส่ comment ก็อบที่ไม่ได้ใส่ comment ไปใช้เท่านั้น

                -- ตั้งชื่อ webhook ด้วย ตั้งอะไรก็ได้ หรือจะอิงแบบดั้งเดิมใน pcall ก็ได้ แต่ขอให้ตรงใน Config ของ Log Script ก็พอ

                                    -- ตั้งชื่อนะ ไม่ใช่เอา webhook มาแปะนะเห้ย มันไม่ทำงานนะ เตือนแล้วนะ

                    -- เช็ค version log ของตัวเองด้วยว่าเป็นเวอร์ชั่นอะไร เพราะถ้าใช้ exports ใน version เก่าจะไม่สามารถใช้ได้

                            -- !! เบสบางตัวอาจตัด function ออกไปบ้าง หากหาไม่เจอก็ไม่ต้องใส่ และไม่ต้องไปหามาใส่ !!

                                              --[[    es_extended/config.lua  ]]

                            -- [[ เพิ่ม config เพื่อเลือกใช้งานว่าเป็น exports = true หรือ TriggerEvent = false ]]

                                    Config.exports_azaellog = true -- Recommend true (resmon 0.0x)

                                            --[[ es_extended/server/commands.lua ]]--

                                    local azlog = Config.exports_azaellog -- ไว้ข้างบน บรรทัดใหนก็ได้

                        --[[  ค้นหา 'setjob' และนำโค้ดไปวางไว้ที่ข้างล่าง args.playerId.setJob(args.job, args.grade)  ]]--

    if azlog == true then
        pcall(function()
            if xPlayer.source == args.playerId.source then
                exports['azael_dc-serverlogs']:insertData({
                    event = 'AdminCommands',
                    content = ('เปลี่ยนอาชีพให้ตนเองเป็น %s ระดับ %s'):format(args.job, args.grade),
                    source = xPlayer.source,
                    color = 7
                })
            else
                exports['azael_dc-serverlogs']:insertData({
                    event = 'AdminCommands',
                    content = ('เปลี่ยนอาชีพให้ %s เป็น %s ระดับ %s'):format(args.playerId.name, args.job, args.grade),
                    source = xPlayer.source,
                    color = 3
                })
        
                exports['azael_dc-serverlogs']:insertData({
                    event = 'AdminCommands',
                    content = ('ถูกเปลี่ยนอาชีพเป็น %s ระดับ %s โดย %s'):format(args.job, args.grade, xPlayer.name),
                    source = args.playerId.source,
                    color = 2
                })
            end
        end)               
    else
        if xPlayer.source == args.playerId.source then
            local sendToDiscord = ''.. xPlayer.name .. ' เปลี่ยนอาชีพให้ตนเอง เป็น ' .. args.job .. ' ระดับ ' .. args.grade .. ''
            TriggerEvent('azael_dc-serverlogs:sendToDiscord', 'ตั้งชื่อด้วย เดี๋ยวโดนยิง', sendToDiscord, xPlayer.source, '^2')
        else
            local sendToDiscord = ''.. xPlayer.name .. ' เปลี่ยนอาชีพให้ ' .. args.playerId.name ..' เป็น ' .. args.job .. ' ระดับ ' .. args.grade .. ''
            TriggerEvent('azael_dc-serverlogs:sendToDiscord', 'ตั้งชื่อด้วย เดี๋ยวโดนยิง', sendToDiscord, xPlayer.source, '^3')

            Citizen.Wait(100)

            local sendToDiscord = ''.. args.playerId.name .. ' ถูกเปลี่ยนอาชีพเป็น ' .. args.job .. ' ระดับ ' .. args.grade .. ' โดย ' .. xPlayer.name ..' '
            TriggerEvent('azael_dc-serverlogs:sendToDiscord', 'ตั้งชื่อด้วย เดี๋ยวโดนยิง', sendToDiscord, args.playerId.source, '^2')
        end
    end

            --[[  ค้นหา 'setaccountmoney' และนำโค้ดไปวางไว้ที่ข้างล่าง args.playerId.setAccountMoney(args.account, args.amount)  ]]--

    if azlog == true then
        pcall(function()
            if xPlayer.source == args.playerId.source then
                exports['azael_dc-serverlogs']:insertData({
                    event = 'AdminCommands',
                    content = ('กำหนด %s ให้ตนเองเป็น $%s'):format(args.account, ESX.Math.GroupDigits(args.amount)),
                    source = xPlayer.source,
                    color = 2,
                    options = {
                        important = (args.amount >= 100000 and true)
                    }
                })
            else
                exports['azael_dc-serverlogs']:insertData({
                    event = 'AdminCommands',
                    content = ('กำหนด %s ให้ %s เป็น $%s'):format(args.account, args.playerId.name, ESX.Math.GroupDigits(args.amount)),
                    source = xPlayer.source,
                    color = 3,
                    options = {
                        important = (args.amount >= 100000 and true)
                    }
                })
        
                exports['azael_dc-serverlogs']:insertData({
                    event = 'AdminCommands',
                    content = ('ถูกกำหนด %s เป็น $%s โดย %s'):format(args.account, ESX.Math.GroupDigits(args.amount), xPlayer.name),
                    source = args.playerId.source,
                    color = 2,
                    options = {
                        important = (args.amount >= 100000 and true)
                    }
                })
            end
        end)
    else
        if xPlayer.source == args.playerId.source then
            local sendToDiscord = ''.. xPlayer.name .. ' กำหนด ' .. args.account .. ' ให้ตนเอง เป็น $' .. ESX.Math.GroupDigits(args.amount) .. ''
            TriggerEvent('azael_dc-serverlogs:sendToDiscord', 'ตั้งชื่อด้วย เดี๋ยวโดนยิง', sendToDiscord, xPlayer.source, '^2')
        else
            local sendToDiscord = ''.. xPlayer.name .. ' กำหนด ' .. args.account .. ' ให้ '.. args.playerId.name .. ' เป็น $' .. ESX.Math.GroupDigits(args.amount) .. ''
            TriggerEvent('azael_dc-serverlogs:sendToDiscord', 'ตั้งชื่อด้วย เดี๋ยวโดนยิง', sendToDiscord, xPlayer.source, '^3')

            Citizen.Wait(100)

            local sendToDiscord = ''.. args.playerId.name .. ' ถูกกำหนด ' .. args.account .. ' เป็น $' .. ESX.Math.GroupDigits(args.amount) .. ' โดย ' .. xPlayer.name ..''
            TriggerEvent('azael_dc-serverlogs:sendToDiscord', 'ตั้งชื่อด้วย เดี๋ยวโดนยิง', sendToDiscord, args.playerId.source, '^2')
        end
    end

                --[[  ค้นหา 'giveaccountmoney' และนำโค้ดไปวางไว้ที่ข้างล่าง args.playerId.addAccountMoney(args.account, args.amount)  ]]--
    
    if azlog == true then
        pcall(function()
            if xPlayer.source == args.playerId.source then
                exports['azael_dc-serverlogs']:insertData({
                    event = 'AdminCommands',
                    content = ('เพิ่ม %s จำนวน $%s ให้ตนเอง'):format(args.account, ESX.Math.GroupDigits(args.amount)),
                    source = xPlayer.source,
                    color = 2,
                    options = {
                        important = (args.amount >= 100000 and true)
                    }
                })
            else
                exports['azael_dc-serverlogs']:insertData({
                    event = 'AdminCommands',
                    content = ('เพิ่ม %s จำนวน $%s ให้ %s'):format(args.account, ESX.Math.GroupDigits(args.amount), args.playerId.name),
                    source = xPlayer.source,
                    color = 3,
                    options = {
                        important = (args.amount >= 100000 and true)
                    }
                })
        
                exports['azael_dc-serverlogs']:insertData({
                    event = 'AdminCommands',
                    content = ('ได้รับ %s จำนวน $%s โดย %s'):format(args.account, ESX.Math.GroupDigits(args.amount), xPlayer.name),
                    source = args.playerId.source,
                    color = 2,
                    options = {
                        important = (args.amount >= 100000 and true)
                    }
                })
            end
        end)
    else
        if xPlayer.source == args.playerId.source then
            local sendToDiscord = ''.. xPlayer.name .. ' เพิ่ม ' .. args.account .. ' จำนวน $' .. ESX.Math.GroupDigits(args.amount) .. ' ให้ตนเอง'
            TriggerEvent('azael_dc-serverlogs:sendToDiscord', 'ตั้งชื่อด้วย เดี๋ยวโดนยิง', sendToDiscord, xPlayer.source, '^2')
        else
            local sendToDiscord = ''.. xPlayer.name .. ' เพิ่ม ' .. args.account .. ' จำนวน $' .. ESX.Math.GroupDigits(args.amount) .. ' ให้ '.. args.playerId.name .. ''
            TriggerEvent('azael_dc-serverlogs:sendToDiscord', 'ตั้งชื่อด้วย เดี๋ยวโดนยิง', sendToDiscord, xPlayer.source, '^3')
        
            Citizen.Wait(100)
        
            local sendToDiscord = ''.. args.playerId.name .. ' ได้รับ ' .. args.account .. ' จำนวน $' .. ESX.Math.GroupDigits(args.amount) .. ' โดย ' .. xPlayer.name ..''
            TriggerEvent('azael_dc-serverlogs:sendToDiscord', 'ตั้งชื่อด้วย เดี๋ยวโดนยิง', sendToDiscord, args.playerId.source, '^2')
        end
    end

                      --[[  ค้นหา 'giveitem' และนำโค้ดไปวางไว้ที่ข้างล่าง args.playerId.addInventoryItem(args.item, args.count)  ]]--

    if azlog == true then
        pcall(function()
            if xPlayer.source == args.playerId.source then
                exports['azael_dc-serverlogs']:insertData({
                    event = 'AdminCommands',
                    content = ('เพิ่ม %s จำนวน %s ให้ตนเอง'):format(ESX.GetItemLabel(args.item), args.count),
                    source = xPlayer.source,
                    color = 2,
                    options = {
                        important = (args.count >= 500 and true)
                    }
                })
            else
                exports['azael_dc-serverlogs']:insertData({
                    event = 'AdminCommands',
                    content = ('เพิ่ม %s จำนวน %s ให้ %s'):format(ESX.GetItemLabel(args.item), args.count, args.playerId.name),
                    source = xPlayer.source,
                    color = 3,
                    options = {
                        important = (args.count >= 500 and true)
                    }
                })
        
                exports['azael_dc-serverlogs']:insertData({
                    event = 'AdminCommands',
                    content = ('ได้รับ %s จำนวน %s โดย %s'):format(ESX.GetItemLabel(args.item), args.count, xPlayer.name),
                    source = args.playerId.source,
                    color = 2,
                    options = {
                        important = (args.count >= 500 and true)
                    }
                })
            end
        end)
    else
        if xPlayer.source == args.playerId.source then
            local sendToDiscord = ''.. xPlayer.name .. ' เพิ่ม ' .. ESX.GetItemLabel(args.item) .. ' จำนวน ' .. ESX.Math.GroupDigits(args.count) .. ' ให้ตนเอง'
            TriggerEvent('azael_dc-serverlogs:sendToDiscord', 'ตั้งชื่อด้วย เดี๋ยวโดนยิง', sendToDiscord, xPlayer.source, '^2')
        else
            local sendToDiscord = ''.. xPlayer.name .. ' เพิ่ม ' .. ESX.GetItemLabel(args.item) .. ' จำนวน ' .. ESX.Math.GroupDigits(args.count) .. ' ให้ '.. args.playerId.name .. ' '
            TriggerEvent('azael_dc-serverlogs:sendToDiscord', 'ตั้งชื่อด้วย เดี๋ยวโดนยิง', sendToDiscord, xPlayer.source, '^3')
        
            Citizen.Wait(100)
        
            local sendToDiscord = ''.. args.playerId.name .. ' ได้รับ ' .. ESX.GetItemLabel(args.item) .. ' จำนวน ' .. ESX.Math.GroupDigits(args.count) .. ' โดย ' .. xPlayer.name ..''
            TriggerEvent('azael_dc-serverlogs:sendToDiscord', 'ตั้งชื่อด้วย เดี๋ยวโดนยิง', sendToDiscord, args.playerId.source, '^2')
        end
    end
                        --[[  ค้นหา 'giveweapon' และนำโค้ดไปวางไว้ที่ข้างล่าง args.playerId.addWeapon(args.weapon, args.ammo)  ]]--

    if azlog == true then
        pcall(function()
            if xPlayer.source == args.playerId.source then
                exports['azael_dc-serverlogs']:insertData({
                    event = 'AdminCommands',
                    content = ('เพิ่ม %s และ กระสุน จำนวน %s ให้ตนเอง'):format(ESX.GetWeaponLabel(args.weapon), args.ammo),
                    source = xPlayer.source,
                    color = 2
                })
            else
                exports['azael_dc-serverlogs']:insertData({
                    event = 'AdminCommands',
                    content = ('เพิ่ม %s และ กระสุน จำนวน %s ให้ %s'):format(ESX.GetWeaponLabel(args.weapon), args.ammo, args.playerId.name),
                    source = xPlayer.source,
                    color = 3
                })
        
                exports['azael_dc-serverlogs']:insertData({
                    event = 'AdminCommands',
                    content = ('ได้รับ %s และ กระสุน จำนวน %s โดย %s'):format(ESX.GetWeaponLabel(args.weapon), args.ammo, xPlayer.name),
                    source = args.playerId.source,
                    color = 2
                })
            end
        end)
    else
        if xPlayer.source == args.playerId.source then
            local sendToDiscord = ''.. xPlayer.name .. ' เพิ่ม ' .. ESX.GetWeaponLabel(args.weapon) .. ' และ กระสุน จำนวน ' .. ESX.Math.GroupDigits(args.ammo) .. ' ให้ตนเอง'
            TriggerEvent('azael_dc-serverlogs:sendToDiscord', 'ตั้งชื่อด้วย เดี๋ยวโดนยิง', sendToDiscord, xPlayer.source, '^2')
        else
            local sendToDiscord = ''.. xPlayer.name .. ' เพิ่ม ' .. ESX.GetWeaponLabel(args.weapon) .. ' และ กระสุน จำนวน ' .. ESX.Math.GroupDigits(args.ammo) .. ' ให้ '.. args.playerId.name .. ''
            TriggerEvent('azael_dc-serverlogs:sendToDiscord', 'ตั้งชื่อด้วย เดี๋ยวโดนยิง', sendToDiscord, xPlayer.source, '^3')
        
            Citizen.Wait(100)
        
            local sendToDiscord = ''.. args.playerId.name .. ' ได้รับ ' .. ESX.GetWeaponLabel(args.weapon) .. ' และ กระสุน จำนวน ' .. ESX.Math.GroupDigits(args.ammo) .. ' โดย ' .. xPlayer.name ..''
            TriggerEvent('azael_dc-serverlogs:sendToDiscord', 'ตั้งชื่อด้วย เดี๋ยวโดนยิง', sendToDiscord, args.playerId.source, '^2')
        end
    end

            --[[  ค้นหา 'giveweaponcomponent' และนำโค้ดไปวางไว้ที่ข้างล่าง args.playerId.addWeaponComponent(args.weaponName, args.componentName)  ]]--

    if azlog == true then
        pcall(function()
            if xPlayer.source == args.playerId.source then
                exports['azael_dc-serverlogs']:insertData({
                    event = 'AdminCommands',
                    content = ('เพิ่ม %s ส่วนประกอบของ %s ให้ตนเอง'):format(component.label, ESX.GetWeaponLabel(args.weaponName)),
                    source = xPlayer.source,
                    color = 2
                })
            else
                exports['azael_dc-serverlogs']:insertData({
                    event = 'AdminCommands',
                    content = ('เพิ่ม %s ส่วนประกอบของ %s ให้ %s'):format(component.label, ESX.GetWeaponLabel(args.weaponName), args.playerId.name),
                    source = xPlayer.source,
                    color = 3
                })
        
                exports['azael_dc-serverlogs']:insertData({
                    event = 'AdminCommands',
                    content = ('ได้รับ %s ส่วนประกอบของ %s โดย %s'):format(component.label, ESX.GetWeaponLabel(args.weaponName), xPlayer.name),
                    source = args.playerId.source,
                    color = 2
                })
            end
        end)
    else
        if xPlayer.source == args.playerId.source then
            local sendToDiscord = ''.. xPlayer.name .. ' เพิ่ม ' .. component.label .. ' ส่วนประกอบของ ' .. ESX.GetWeaponLabel(args.weaponName) .. ' ให้ตนเอง'
            TriggerEvent('azael_dc-serverlogs:sendToDiscord', 'ตั้งชื่อด้วย เดี๋ยวโดนยิง', sendToDiscord, xPlayer.source, '^2')
        else
            local sendToDiscord = ''.. xPlayer.name .. ' เพิ่ม ' .. component.label .. ' ส่วนประกอบของ ' .. ESX.GetWeaponLabel(args.weaponName) .. ' ให้ '.. args.playerId.name .. ''
            TriggerEvent('azael_dc-serverlogs:sendToDiscord', 'ตั้งชื่อด้วย เดี๋ยวโดนยิง', sendToDiscord, xPlayer.source, '^3')
        
            Citizen.Wait(100)
        
            local sendToDiscord = ''.. args.playerId.name .. ' ได้รับ ' .. component.label .. ' ส่วนประกอบของ ' .. ESX.GetWeaponLabel(args.weaponName) .. ' โดย ' .. xPlayer.name ..''
            TriggerEvent('azael_dc-serverlogs:sendToDiscord', 'ตั้งชื่อด้วย เดี๋ยวโดนยิง', sendToDiscord, args.playerId.source, '^2')
        end
    end
--============================================================================================================================================================================================================--

                                                --[[ es_extended/server/main.lua ]]--

                                    local azlog = Config.exports_azaellog -- ไว้ข้างบน บรรทัดใหนก็ได้

                                                   --[[ esx:giveInventoryItem ]]--

                        --[[  ค้นหา 'item_standard' และนำโค้ดไปวางไว้ที่ข้างล่าง targetXPlayer.addInventoryItem(itemName, itemCount)  ]]--

    if azlog == true then
        pcall(function()
            exports['azael_dc-serverlogs']:insertData({
                event = 'GiveItem',
                content = ('ส่ง %s จำนวน %s ให้กับ %s'):format(sourceItem.label, itemCount, targetXPlayer.name),
                source = sourceXPlayer.source,
                color = 1,
                options = {
                    important = (itemCount >= 500 and true)
                }
            })
        
            exports['azael_dc-serverlogs']:insertData({
                event = 'GiveItem',
                content = ('ได้รับ %s จำนวน %s จาก %s'):format(sourceItem.label, itemCount, sourceXPlayer.name),
                source = targetXPlayer.source,
                color = 2,
                options = {
                    important = (itemCount >= 500 and true)
                }
            })
        end)
    else
        local sendToDiscord = ''.. sourceXPlayer.name .. ' ส่ง ' .. ESX.GetItemLabel(itemName) .. ' ให้กับ ' .. targetXPlayer.name .. ' จำนวน ' .. ESX.Math.GroupDigits(itemCount) .. ''
        TriggerEvent('azael_dc-serverlogs:sendToDiscord', 'ตั้งชื่อด้วย เดี๋ยวโดนยิง', sendToDiscord, sourceXPlayer.source, '^1')	
                        
        Citizen.Wait(100)
                        
        local sendToDiscord2 = ''.. targetXPlayer.name .. ' ได้รับ ' .. ESX.GetItemLabel(itemName) .. ' จาก ' .. sourceXPlayer.name .. ' จำนวน ' .. ESX.Math.GroupDigits(itemCount) .. ''
        TriggerEvent('azael_dc-serverlogs:sendToDiscord', 'ตั้งชื่อด้วย เดี๋ยวโดนยิง', sendToDiscord2, targetXPlayer.source, '^2')
    end

                                --[[  ค้นหา 'item_money' และนำโค้ดไปวางไว้ที่ข้างล่าง targetXPlayer.addMoney(itemCount))  ]]--

    if azlog == true then
        pcall(function()
            local eventName = (itemName == 'money' and 'GiveMoney' or 'GiveDirtyMoney')
        
            exports['azael_dc-serverlogs']:insertData({
                event = eventName,
                content = ('ส่ง %s จำนวน $%s ให้กับ %s'):format(Config.Accounts[itemName].label, ESX.Math.GroupDigits(itemCount), targetXPlayer.name),
                source = sourceXPlayer.source,
                color = 1,
                options = {
                    important = (itemCount >= 100000 and true)
                }
            })
        
            exports['azael_dc-serverlogs']:insertData({
                event = eventName,
                content = ('ได้รับ %s จำนวน $%s จาก %s'):format(Config.Accounts[itemName].label, ESX.Math.GroupDigits(itemCount), sourceXPlayer.name),
                source = targetXPlayer.source,
                color = 2,
                options = {
                    important = (itemCount >= 100000 and true)
                }
            })
        end)
    else
        local sendToDiscord = ''.. sourceXPlayer.name .. ' ส่ง '.. Config.Accounts[itemName] ..' ให้กับ ' .. targetXPlayer.name .. ' จำนวน $' .. ESX.Math.GroupDigits(itemCount) .. ''
        TriggerEvent('azael_dc-serverlogs:sendToDiscord', 'ตั้งชื่อด้วย เดี๋ยวโดนยิง', sendToDiscord, sourceXPlayer.source, '^1')	
                    
        Citizen.Wait(100)
                    
        local sendToDiscord2 = ''.. targetXPlayer.name .. ' ได้รับ '.. Config.Accounts[itemName] ..' จาก ' .. sourceXPlayer.name .. ' จำนวน $' .. ESX.Math.GroupDigits(itemCount) .. ''
        TriggerEvent('azael_dc-serverlogs:sendToDiscord', 'ตั้งชื่อด้วย เดี๋ยวโดนยิง', sendToDiscord2, targetXPlayer.source, '^2')
    end

                            --[[  ค้นหา 'item_account' และนำโค้ดไปวางไว้ที่ข้างล่าง targetXPlayer.addAccountMoney(itemName, itemCount)  ]]--
    if azlog == true then
        pcall(function()
            local eventName = (itemName == 'money' and 'GiveMoney' or 'GiveDirtyMoney')
        
            exports['azael_dc-serverlogs']:insertData({
                event = eventName,
                content = ('ส่ง %s จำนวน $%s ให้กับ %s'):format(Config.Accounts[itemName].label, ESX.Math.GroupDigits(itemCount), targetXPlayer.name),
                source = sourceXPlayer.source,
                color = 1,
                options = {
                    important = (itemCount >= 100000 and true)
                }
            })
        
            exports['azael_dc-serverlogs']:insertData({
                event = eventName,
                content = ('ได้รับ %s จำนวน $%s จาก %s'):format(Config.Accounts[itemName].label, ESX.Math.GroupDigits(itemCount), sourceXPlayer.name),
                source = targetXPlayer.source,
                color = 2,
                options = {
                    important = (itemCount >= 100000 and true)
                }
            })
        end)
    else
        local sendToDiscord = ''.. sourceXPlayer.name .. ' ส่ง '.. Config.Accounts[itemName] ..' ให้กับ ' .. targetXPlayer.name .. ' จำนวน $' .. ESX.Math.GroupDigits(itemCount) .. ''
        TriggerEvent('azael_dc-serverlogs:sendToDiscord', 'ตั้งชื่อด้วย เดี๋ยวโดนยิง', sendToDiscord, sourceXPlayer.source, '^1')	
                    
        Citizen.Wait(100)
                    
        local sendToDiscord2 = ''.. targetXPlayer.name .. ' ได้รับ '.. Config.Accounts[itemName] ..' จาก ' .. sourceXPlayer.name .. ' จำนวน $' .. ESX.Math.GroupDigits(itemCount) .. ''
        TriggerEvent('azael_dc-serverlogs:sendToDiscord', 'ตั้งชื่อด้วย เดี๋ยวโดนยิง', sendToDiscord2, targetXPlayer.source, '^2')
    end
                           --[[  ค้นหา 'item_weapon' และนำโค้ดไปวางไว้ที่ข้างล่าง targetXPlayer.addWeapon(itemName, itemCount)  ]]--

    if azlog == true then
        pcall(function()
            exports['azael_dc-serverlogs']:insertData({
                event = 'GiveWeapon',
                content = ('ส่ง %s และ กระสุน จำนวน %s ให้กับ %s'):format(weaponLabel, itemCount, targetXPlayer.name),
                source = sourceXPlayer.source,
                color = 1
            })
        
            exports['azael_dc-serverlogs']:insertData({
                event = 'GiveWeapon',
                content = ('ได้รับ %s และ กระสุน จำนวน %s จาก %s'):format(weaponLabel, itemCount, sourceXPlayer.name),
                source = targetXPlayer.source,
                color = 2
            })
        end)
    else
        if weaponObject.ammo and itemCount > 0 then
            local sendToDiscord = ''.. sourceXPlayer.name .. ' ส่ง '.. weaponLabel ..' และ กระสุน จำนวน ' .. ESX.Math.GroupDigits(itemCount) .. ' ให้กับ ' .. targetXPlayer.name .. ''
            TriggerEvent('azael_dc-serverlogs:sendToDiscord', 'ตั้งชื่อด้วย เดี๋ยวโดนยิง', sendToDiscord, sourceXPlayer.source, '^1')	
                
            Citizen.Wait(100)
                
            local sendToDiscord2 = ''.. targetXPlayer.name .. ' ได้รับ '.. weaponLabel ..' และ กระสุน จำนวน ' .. ESX.Math.GroupDigits(itemCount) .. ' จาก ' .. sourceXPlayer.name .. ''
            TriggerEvent('azael_dc-serverlogs:sendToDiscord', 'ตั้งชื่อด้วย เดี๋ยวโดนยิง', sendToDiscord2, targetXPlayer.source, '^2')
        else
            local sendToDiscord = ''.. sourceXPlayer.name .. ' ส่ง '.. weaponLabel ..' ให้กับ ' .. targetXPlayer.name .. ''
            TriggerEvent('azael_dc-serverlogs:sendToDiscord', 'ตั้งชื่อด้วย เดี๋ยวโดนยิง', sendToDiscord, sourceXPlayer.source, '^1')	
                
            Citizen.Wait(100)
                
            local sendToDiscord2 = ''.. targetXPlayer.name .. ' ได้รับ '.. weaponLabel ..' จาก ' .. sourceXPlayer.name .. ''
            TriggerEvent('azael_dc-serverlogs:sendToDiscord', 'ตั้งชื่อด้วย เดี๋ยวโดนยิง', sendToDiscord2, targetXPlayer.source, '^2')
        end
    end
                        --[[  ค้นหา 'item_ammo' และนำโค้ดไปวางไว้ที่ข้างล่าง targetXPlayer.addWeaponAmmo(itemName, itemCount)  ]]--

    if azlog == true then
        pcall(function()
            exports['azael_dc-serverlogs']:insertData({
                event = 'GiveAmmo',
                content = ('ส่ง กระสุน ของ %s จำนวน %s ให้กับ %s'):format(weapon.label, itemCount, targetXPlayer.name),
                source = sourceXPlayer.source,
                color = 1
            })

            exports['azael_dc-serverlogs']:insertData({
                event = 'GiveAmmo',
                content = ('ได้รับ กระสุน ของ %s จำนวน %s จาก %s'):format(weapon.label, itemCount, sourceXPlayer.name),
                source = targetXPlayer.source,
                color = 2
            })
        end)
    else
        local sendToDiscord = ''.. sourceXPlayer.name .. ' ส่ง กระสุน ของ ' .. weapon.label .. ' จำนวน ' .. ESX.Math.GroupDigits(itemCount) .. ' ให้กับ ' .. targetXPlayer.name .. ''
        TriggerEvent('azael_dc-serverlogs:sendToDiscord', 'ตั้งชื่อด้วย เดี๋ยวโดนยิง', sendToDiscord, sourceXPlayer.source, '^1')	
            
        Citizen.Wait(100)
            
        local sendToDiscord2 = ''.. targetXPlayer.name .. ' ได้รับ กระสุน ของ ' .. weapon.label .. ' จำนวน ' .. ESX.Math.GroupDigits(itemCount) .. ' จาก ' .. sourceXPlayer.name .. ''
        TriggerEvent('azael_dc-serverlogs:sendToDiscord', 'ตั้งชื่อด้วย เดี๋ยวโดนยิง', sendToDiscord2, targetXPlayer.source, '^2')
    end

                                        --[[ esx:removeInventoryItem ]]--

        --[[  ค้นหา 'item_standard' และนำโค้ดไปวางไว้ที่ข้างล่าง xPlayer.removeInventoryItem(itemName, itemCount)  ]]--

    if azlog == true then
        pcall(function()
            exports['azael_dc-serverlogs']:insertData({
                event = 'RemoveItem',
                content = ('ทิ้ง %s จำนวน %s'):format(xItem.label, itemCount),
                source = xPlayer.source,
                color = 1,
                options = {
                    important = (itemCount >= 500 and true)
                }
            })
        end)
    else
        local sendToDiscord = ''.. xPlayer.name .. ' ทิ้ง '.. xItem.label ..' จำนวน ' .. ESX.Math.GroupDigits(itemCount) .. ''
        TriggerEvent('azael_dc-serverlogs:sendToDiscord', 'ตั้งชื่อด้วย เดี๋ยวโดนยิง', sendToDiscord, xPlayer.source, '^1')
    end

        --[[  ค้นหา 'item_account' และนำโค้ดไปวางไว้ที่ข้างล่าง xPlayer.removeAccountMoney(itemName, itemCount)  ]]--

    if azlog == true then
        pcall(function()
            exports['azael_dc-serverlogs']:insertData({
                event = (itemName == 'money' and 'RemoveMoney' or 'RemoveDirtyMoney'),
                content = ('ทิ้ง %s จำนวน $%s'):format(Config.Accounts[itemName].label, ESX.Math.GroupDigits(itemCount)),
                source = xPlayer.source,
                color = 1,
                options = {
                    important = (itemCount >= 100000 and true)
                }
            })
        end)
    else
        local sendToDiscord = ''.. xPlayer.name .. ' ทิ้ง ' .. account.label .. ' จำนวน $' .. ESX.Math.GroupDigits(itemCount) .. ''
        TriggerEvent('azael_dc-serverlogs:sendToDiscord', 'ตั้งชื่อด้วย เดี๋ยวโดนยิง', sendToDiscord, xPlayer.source, '^1')
    end
                    
                --[[  ค้นหา 'item_weapon' และนำโค้ดไปวางไว้ที่ข้างล่าง xPlayer.removeWeapon(itemName)  ]]--

    if azlog == true then
        pcall(function()
            exports['azael_dc-serverlogs']:insertData({
                event = 'RemoveWeapon',
                content = ('ทิ้ง %s และ กระสุน จำนวน %s'):format(weapon.label, weapon.ammo),
                source = xPlayer.source,
                color = 1
            })
        end)
    else
        if weaponObject.ammo and weapon.ammo > 0 then
            local sendToDiscord = ''.. xPlayer.name .. ' ทิ้ง ' .. weapon.label .. ' และ กระสุน จำนวน ' .. ESX.Math.GroupDigits(weapon.ammo) .. ''
            TriggerEvent('azael_dc-serverlogs:sendToDiscord', 'ตั้งชื่อด้วย เดี๋ยวโดนยิง', sendToDiscord, xPlayer.source, '^1')
        else
            local sendToDiscord = ''.. xPlayer.name .. ' ทิ้ง ' .. weapon.label .. ''
            TriggerEvent('azael_dc-serverlogs:sendToDiscord', 'ตั้งชื่อด้วย เดี๋ยวโดนยิง', sendToDiscord, xPlayer.source, '^1')
        end
    end                                       

                                            --[[ esx:useItem ]]--

                --[[  นำโค้ดไปวางไว้ที่ข้างล่างของข้างล่าง ESX.UseItem(source, itemName)  ]]--

    if azlog == true then
        pcall(function()
            exports['azael_dc-serverlogs']:insertData({
                event = 'UseItem',
                content = ('ใช้งาน %s จำนวน 1'):format(ESX.GetItemLabel(itemName)),
                source = xPlayer.source,
                color = 3
            })
        end)
    else
        local sendToDiscord = ''.. xPlayer.name .. ' ใช้ไอเทม ' .. ESX.GetItemLabel(itemName) .. ' จำนวน 1'
        TriggerEvent('azael_dc-serverlogs:sendToDiscord', 'ตั้งชื่อด้วย เดี๋ยวโดนยิง', sendToDiscord, xPlayer.source, '^3')
    end                                    
                                            --[[ esx:onPickup ]]--

    --[[  ค้นหา 'item_standard' และนำโค้ดไปวางไว้ที่ข้างล่าง xPlayer.addInventoryItem(pickup.name, pickup.count)  ]]--

    if azlog == true then
        pcall(function()
            exports['azael_dc-serverlogs']:insertData({
                event = 'PickupItem',
                content = ('เก็บ %s จำนวน %s'):format(ESX.GetItemLabel(pickup.name), pickup.count),
                source = xPlayer.source,
                color = 2,
                options = {
                    important = (pickup.count >= 500 and true)
                }
            })
        end)
    else
        local sendToDiscord = ''.. xPlayer.name .. ' เก็บ ' .. ESX.GetItemLabel(pickup.name) .. ' จำนวน ' .. ESX.Math.GroupDigits(pickup.count) ..''
        TriggerEvent('azael_dc-serverlogs:sendToDiscord', 'ตั้งชื่อด้วย เดี๋ยวโดนยิง', sendToDiscord, xPlayer.source, '^2')
    end

     --[[  ค้นหา 'item_account' และนำโค้ดไปวางไว้ที่ข้างล่าง xPlayer.addAccountMoney(pickup.name, pickup.count)  ]]--

    if azlog == true then
        pcall(function()
            exports['azael_dc-serverlogs']:insertData({
                event = (pickup.name == 'money' and 'PickupMoney' or 'PickupDirtyMoney'),
                content = ('เก็บ %s จำนวน $%s'):format(Config.Accounts[pickup.name].label, ESX.Math.GroupDigits(pickup.count)),
                source = xPlayer.source,
                color = 2,
                options = {
                    important = (pickup.count >= 100000 and true)
                }
            })
        end)
    else
        local sendToDiscord = ''.. xPlayer.name .. ' เก็บ ' .. Config.Accounts[pickup.name] .. ' จำนวน $' .. ESX.Math.GroupDigits(pickup.count) ..''
        TriggerEvent('azael_dc-serverlogs:sendToDiscord', 'ตั้งชื่อด้วย เดี๋ยวโดนยิง', sendToDiscord, xPlayer.source, '^2')
    end

    --[[  ค้นหา 'item_weapon' และนำโค้ดไปวางไว้ที่ข้างล่าง xPlayer.setWeaponTint(pickup.name, pickup.tintIndex)  ]]--

    if azlog == true then
        pcall(function()
            exports['azael_dc-serverlogs']:insertData({
                event = 'PickupWeapon',
                content = ('เก็บ %s และ กระสุน จำนวน %s'):format(ESX.GetWeaponLabel(pickup.name), pickup.count),
                source = xPlayer.source,
                color = 2
            })
        end)
    else
        if pickup.count > 0 then
            local sendToDiscord = ''.. xPlayer.name .. ' ทิ้ง ' .. ESX.GetWeaponLabel(pickup.name) .. ' และ กระสุน จำนวน ' .. ESX.Math.GroupDigits(pickup.count) .. ''
            TriggerEvent('azael_dc-serverlogs:sendToDiscord', 'ตั้งชื่อด้วย เดี๋ยวโดนยิง', sendToDiscord, xPlayer.source, '^2')
        else
            local sendToDiscord = ''.. xPlayer.name .. ' ทิ้ง ' .. ESX.GetWeaponLabel(pickup.name) .. ''
            TriggerEvent('azael_dc-serverlogs:sendToDiscord', 'ตั้งชื่อด้วย เดี๋ยวโดนยิง', sendToDiscord, xPlayer.source, '^2')
        end
    end

--============================================================================================================================================================================================================--

