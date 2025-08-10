export async function addItem(userCart, item){
  userCart.push(item);
}

export async function deleteItem(userCart, name){
  const index = userCart.findIndex((item) => item.name === name);

  if (index !== -1) {
    userCart.splice(index, 1);
  }
}

export async function removeItemByIndex(userCart, index){
  const deleteIndex = index - 1;
  
  if(index >= 0 && index < userCart.length){
    userCart.splice(deleteIndex, 1);
  }
}

export async function removeItem(userCart, item){
  const indexFound = userCart.findIndex((p) => p.name === item.name);

  if (indexFound === -1) {
    console.log("Item não encontrado!");
    return;
  }

  if (userCart[indexFound].quantity > 1) {
    userCart[indexFound].quantity -= 1; 
    return;
  }

  if (userCart[indexFound].quantity === 1) {
    userCart[indexFound].splice(indexFound, 1);
  }
}

export async function calculateTotal(userCart) {
  const result = userCart.reduce((total, item) => total + item.subTotal, 0);
  console.log("\nShopee cart total is:");
  console.log(`$Total: R$ ${result}`);
}

export async function displayCart(userCart) {
  console.log("\nShopee cart list:");
  userCart.array.forEach((item, index)=>{
    console.log(`${index +1}. ${item.name} - R$ ${item.price} | ${item.quantity} | Subtotal: R$ ${item.subTotal}`)
  })
}