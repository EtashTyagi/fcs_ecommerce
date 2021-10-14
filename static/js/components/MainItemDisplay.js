// <!-- path wrt files where html is located-->

class MainItemDisplay extends HTMLElement {
    connectedCallback() {
        const item = JSON.parse(this.attributes.ofItem.value)
        let pos_rating = "", neg_rating = "";
        for (let i = 0; i < Math.min(10, parseInt(item.rating)); i++) {
            pos_rating = pos_rating.concat("⭐")
        }
        for (let i = 0; i < 10 - parseInt(item.rating); i++) {
            neg_rating = neg_rating.concat("☆")
        }
        this.innerHTML=`
        <div class="w-100 d-flex flex-column justify-content-center align-items-center my-2">
            <div class="d-flex flex-column card my-2 p-0 text-start text-dark flex-md-row
            align-items-center align-items-md-start"
                style="width: 90%">
                    <div class="mb-md-2 h-100 mt-2 mt-md-4 px-2 px-md-0 ps-md-2 w-100 d-flex flex-column align-items-center justify-content-center" style="min-width: 300px; max-width: 500px">
                        <img class="card-img-top card-img rounded-0 rounded-top" style="max-width: 500px; max-height: 300px;object-fit: contain" src="${item.image}" alt="Card image cap">
                        <div class="w-100 d-flex justify-content-around flex-column">
                            <div class="card-footer d-flex flex-row align-items-center" style="max-height: 36px">
                                <small class="text-muted"><b>Price:</b></small>
                                <small class="ms-1">${item.price}</small>
                                <span style="font-size: 18px; font-weight: lighter">$</span>
                            </div>
                            <div class="card-footer d-flex flex-row align-items-center w-100" style="max-height: 36px; overflow: hidden">
                                <small class="text-muted"><b>Rating:</b> ${pos_rating}</small>
                                <span style="font-size: 24px">${neg_rating}</span>
                            </div>
                        </div>
                        <div class="w-100 d-flex flex-row justify-content-around flex-md-column">
                            <button class="btn btn-success mt-2 w-100">Add To Cart</button>
                        </div>
                    </div>
                    
                    
                    <div class="card-body pb-0">
                        <h1 class="card-title text-truncate mb-0">${item.title}</h1>
                        <p class="card-text pb-2 mt-0">
                            ${item.description}
                        </p>
                    </div>
                    
            </div>
        </div>`

    }
}

customElements.define('main-item-display', MainItemDisplay);
