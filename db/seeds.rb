Survivor.create({name: 'Jonny', age: 20, gender: 'male', latitude: 27.2038, longitude: 77.5011 })
Survivor.create({name: 'Ahmed', age: 28, gender: 'female', latitude: 28.2038, longitude: 76.5011 })
Item.create([{name:'coke Water',points: 14},{name:'chicken Soup',points: 11},{name:'First Aid kit',points: 20},{name:'ML98',points: 3}])
Survivor.find(1).inventory_items=[InventoryItem.create(item_id: 1, quantity: 5),InventoryItem.create(item_id: 2, quantity: 2)]
Survivor.find(2).inventory_items=[InventoryItem.create(item_id: 2, quantity: 10),InventoryItem.create(item_id: 3, quantity: 3)]