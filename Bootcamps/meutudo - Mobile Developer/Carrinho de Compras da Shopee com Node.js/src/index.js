import {createItem} from "./services/item.js";
import * as cartService from "./services/cart.js";

const myCart = [];
const myWishList = [];

const item1 = await createItem('mustang miniatura', 25.99, 1);
const item2 = await createItem('impreza miniatura', 19.99, 2);

await cartService.addItem(myCart, item1);
await cartService.addItem(myCart, item2);

await cartService.removeItem(myCart, item1);

await cartService.displayCart(myCart);

cartService.calculateTotal(myCart);