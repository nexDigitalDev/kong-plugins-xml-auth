local a, b, c, d = {}, {}, {}, {}

local file = io.open("test.xml", "rb")   
if not file then return end
local txt = file:read("*a")
file:close()

for ref, instances in txt:gmatch('<key-auth ref="(%w+)">(.-)</key-auth>') do
    a[#a+1] = ref   
    APIKEY= instances:match('name="apikey"%s+value="(.-)"')
    if APIKEY then b[#b+1] = APIKEY end
    TARGET_NAME = instances:match('name="TARGET_NAME"%s+value="(.-)"')
    if TARGET_NAME then  c[#c+1] = TARGET_NAME end
end

for relationship in txt:gmatch('<NewRelationship>(.-)</NewRelationship>') do
    parent = relationship:match('<Parent>.-ref="(%w+)".-</Parent>')
    node = relationship:match('<Relations type="contains">.-ref="(%w+)".-</Relations>')
    if parent and node then    d[#d+1] = {  [parent] = node } end
end

for j=1,#a do
   local id = a[j]
    print("KEY : ", id)
    for k,v in  pairs(d) do
        if type(v)=='table' and v[id] then
            print("\tRELATION: ",v[id])
        end
    end
end
