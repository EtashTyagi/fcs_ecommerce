class ItemCard extends HTMLElement {
    connectedCallback() {
        let item = JSON.parse(this.attributes.ofItem.value); // item object
        let pos_rating = "", neg_rating = "";
        for (let i = 0; i < Math.min(10, parseInt(item.rating)); i++) {
            pos_rating = pos_rating.concat("⭐")
        }
        for (let i = 0; i < 10 - parseInt(item.rating); i++) {
            neg_rating = neg_rating.concat("☆")
        }
        this.innerHTML=`
            <a href='/item?id=${item.ID}/' style="text-decoration: inherit; color: inherit; cursor: auto;">
                <div class="card my-2 mx-1 btn btn-outline-light p-0 text-start text-dark" style="width: 350px">
                    <img class="card-img-top card-img" src="${item.image}" alt="Card image cap">
                    <div class="card-body pb-0">
                        <h5 class="card-title text-truncate">${item.title}</h5>
                        <p class="card-text" style="height: 125px; overflow: hidden;text-overflow: fade">
                            ${item.short_desc}
                        </p>
                    </div>
                    <div class="card-footer d-flex flex-row align-items-center" style="max-height: 36px">
                        <small class="text-muted"><b>Price:</b></small>
                        <small class="ms-1">${item.price}</small>
                        <span style="font-size: 18px; font-weight: lighter">$</span>
                    </div>
                    <div class="card-footer d-flex flex-row align-items-center" style="max-height: 36px">
                        <small class="text-muted"><b>Rating:</b> ${pos_rating}</small>
                        <span style="font-size: 24px">${neg_rating}</span>
                    </div>
                </div>
            </a>`

    }
}

customElements.define('item-card', ItemCard);