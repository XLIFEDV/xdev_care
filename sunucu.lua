--Sunucu bakım durumu: (true: aktif,false: deaktif) eder
local sunucuBakim = true 
--Sunucu bakım'da iken kontrol edilcek oyuncu bilgisi: steam,discord,live,xbl,license,ip
local kontroltip = "steam" 
--Bakımda iken giriş yapmaya çalışan oyuncuya gösterilcek bilgi
local hataYazi = "Sunucu bakımda iken giriş yapamazsın" 
--Bakım listesi; Kontrol edilcek bilginin karşılığı
local onayli = {
    "",
}

function toBoolean(deger) local tablo = {["true"]=true,["false"]=false} return (tablo[deger] or nil)
--Dilerseniz komut ismini değiştirebilirsiniz
local komutIsmi = "bakimdurum"
RegisterCommand(komutIsmi,function(s,a) if s > 0 or not a[1] or toBoolean(a[1]) ~= nil then return end sunucuBakim = toBoolean(a[1]) end)

AddEventHandler("playerConnecting",function(ger,eksiz,dosya)
    source = source
    local kontrol = nil
    for k,v in ipairs(GetPlayerIdentifiers(source)) do
        if string.match(v, (kontroltip or "steam")..":") then
            kontrol = string.sub(v, ((#kontroltip) + 2),#v)
            break
        end
    end
    --Yanlış kontroltip olması durumunda kontrol satırları (Dileyen kişiler silebilir:16/22)
    if not kontrol then
        for k,v in ipairs(GetPlayerIdentifiers(source)) do
            if string.match(v, "steam:") then
                kontrol = string.sub(v, "steam:",#v)
                break
            end
        end
    end
    if sunucuBakim then
        if kontrol then
            for k,v in pairs(onayli) do
                if v == kontrol then
                    dosya.done()
                    return
                end
            end
        end
        dosya.done(hataYazi)
    else
        dosya.done()
    end
end)
