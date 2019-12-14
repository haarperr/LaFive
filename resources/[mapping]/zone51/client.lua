local blips = {

    {title="~p~Zone", colour=83, id=84, x = -2017.59, y = 3078.92, z = 20.8}
    }
    Citizen.CreateThread(function()
  
          Citizen.Wait(0)
  
  local bool = true
    
    if bool then
          
          for k,v in pairs(blips) do
             
  
                 zoneblip = AddBlipForRadius(v.x,v.y,v.z, 4000.0)
                            SetBlipSprite(zoneblip,1)
                            SetBlipColour(zoneblip,79)
                            SetBlipAlpha(zoneblip,75)
                           
          end
         
         bool = false
     
     end
  end)