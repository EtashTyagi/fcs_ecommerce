// <!-- path wrt files where html is located-->

class CartItem extends HTMLElement {
    connectedCallback() {
        let item = JSON.parse(this.attributes.ofItem.value)
        let tot_price = (item.price*item.qty).toFixed(3)
        this.style.width = "450px"
        this.style.maxWidth = "100%"
        this.style.flexGrow = "2"
        this.classList = "my-2 mx-2"
        this.innerHTML = `
        <div class="d-flex card p-0 text-start text-dark flex-row align-items-start p-1 pe-2 w-100" style="background:rgba(0,0,0, 0.02);overflow: hidden">
                        <div class=" h-100 px-2 d-flex flex-column align-items-center justify-content-center" style="width: 200px">
                            <a href="/item?id=${item.ID}/"><img class="card-img-top card-img rounded-0 rounded-top" style="width: 200px" src="${item.image}" alt="Card image cap"></a>
                            <div class="card-footer d-flex flex-row align-items-center" style="width:200px; max-height: 36px;overflow: hidden">
                                <small class="text-muted"><b>Cost:</b></small>
                                <small class="ms-1" id="tot_price_${item.ID}" style="overflow: hidden">${tot_price}</small>
                                <span style="font-size: 18px; font-weight: lighter">$</span>
                            </div>

                        </div>
                        <div class="w-100 d-flex flex-column align-items-center justify-content-center" style="width: 150px; overflow: hidden">
                            <div class="card-body p-0 w-100 ps-2 d-flex flex-column" style="overflow: hidden">
                                <span class="card-title h2" style="font-size: xx-large; min-height: 50px; text-overflow: ellipsis;white-space: nowrap;overflow: hidden">${item.title}</span>
                                    <input id="n_items_${item.ID}"
                                        min=1
                                        max=99
                                        class="w-100"
                                        type = "number"
                                        placeholder="Quantity" value="${item.qty}"
                                        oninput="if (this.value.length === 0) return;
                                                 if (this.value > 99) this.value = this.max;
                                                 if (this.value < this.min) this.value = this.min;
                                                 let prev = parseFloat(document.getElementById('tot_price_${item.ID}').innerHTML)
                                                 let user_side_price = (value * ${item.price});
                                                 document.getElementById('tot_price_${item.ID}').innerHTML = user_side_price.toFixed(3).toLocaleString();
                                                 let prev_tot = parseFloat(document.getElementById('client_cost').innerHTML)
                                                 document.getElementById('client_cost').innerHTML = (prev_tot + user_side_price - prev).toFixed(3).toLocaleString();"
                                                 >
                                
                                    <button class="btn btn-danger mt-2 w-100">Remove</button>
                            </div>
                        </div>
                </div>`
    }
}

class CartDisplay extends HTMLElement {

    connectedCallback() {
        const items = FetchCart(69) // Figure a way to put in user id securely (Maybe Cookies)
        let client_cost = 0;
        items.forEach((key) => {client_cost += key.price * key.qty})
        client_cost = client_cost.toFixed(3)
        this.innerHTML=`
<form>
        <div class="w-100 d-flex align-items-center justify-content-center my-2">
        <div class="d-flex flex-column justify-content-center align-items-center my-2 card p-1" style="width: 90%">
            <span class="h1" style="font-size: xxx-large">My Cart</span>
            <div>
                <span class="h1" style="font-size: xx-large">Total Cost: </span> <span class="h1" style="font-size: xx-large" id="client_cost">${client_cost}</span> <span style="font-size: xx-large" id="client_cost">$</span>
            </div>
            <div class="d-flex flex-row flex-wrap w-100 justify-content-evenly align-stretch mt-3">
                ${items.map((element)=>{return `<cart-item ofItem='${JSON.stringify(element)}' init_cost="${client_cost}"></cart-item>`}).join('')}
            </div>
            <button class="btn btn-success my-2" onclick="">Checkout</button>
        </div>
        </div>
        
</form>
        `

    }
}


customElements.define('cart-item', CartItem);
customElements.define('cart-display', CartDisplay);