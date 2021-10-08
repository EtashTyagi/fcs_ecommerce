// <!-- path wrt files where html is located-->

class NavHeader extends HTMLElement {
    connectedCallback() {
        let attributes = this.attributes;
        const active = {Home: (attributes.Home?"active":""),
                        Discounts: (attributes.Discounts?"active":""),
                        Sell: (attributes.Sell?"active":""),
                        Cart: (attributes.Cart?"btn-outline-success":"btn-dark"),
                        Login: (attributes.Login?"btn-outline-success ps-1":"btn-dark ps-0")}
        let search=`<div class="w-100"></div>`;
        if (attributes.Search) {
            search=`
<form class="d-flex mx-0 mx-md-3 w-100">
    <div class="dropdown">
        <a class="rounded-0 rounded-start btn btn-success dropdown-toggle" href="#" id="type"
           role="button" data-bs-toggle="dropdown" aria-expanded="false">
            <span id="selected_item_type">All</span>
        </a>
        <ul class="dropdown-menu dropdown-menu-dark" aria-labelledby="type">
            <li><a class="dropdown-item" href="#All">All</a></li>
            <li>
                <hr class="dropdown-divider">
            </li>
            <li><a class="dropdown-item" href="#Electronics">Electronics</a></li>
            <li><a class="dropdown-item" href="#Laptop">Laptop</a></li>
        </ul>
    </div>
    <input class="form-control rounded-0 border-0" type="search" placeholder="Search"
           aria-label="Search">
    <button class="rounded-0 rounded-end btn btn-success" type="submit">Search</button>
</form>
            `
        }
        this.innerHTML = `
<nav class="shadow-sm navbar navbar-expand-md navbar-dark bg-dark">
  <div class="container-fluid">
    <a class="navbar-brand" href="/">
        <div class="d-flex align-items-center justify-content-center">
            <img alt="company Logo" height="32px" src="/static/res/logoPlaceHolder.png">
            <span class="h-100 ms-1" style="font-weight: 600">FCS</span>
        </div>
    </a>
    <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
      <span class="navbar-toggler-icon"></span>
    </button>
    <div class="collapse navbar-collapse" id="navbarSupportedContent">
      <ul class="navbar-nav me-auto mb-2 mb-md-0">
        <li class="nav-item">
          <a class="nav-link ${active.Home}" "+{active.Home} aria-current="page" href="/">Home</a>
        </li>
        <li class="nav-item">
          <a class="nav-link ${active.Discounts}" href="/discounts">Discounts</a>
        </li>
        <li class="nav-item">
          <a class="nav-link ${active.Sell}" href="/sell">Sell</a>
        </li>
      </ul>
      ${search}      
      <div class="d-flex flex-row me-auto mb-2 mb-md-0">
        <div class="nav-item dropdown pt-2 pt-md-0">
            <a class="dropdown-toggle btn ${active.Login} link-primary ps-md-2" href="#" id="login" role="button" data-bs-toggle="dropdown" aria-expanded="false">
              <img class="rounded-circle" height="28px" src="https://clinicforspecialchildren.org/wp-content/uploads/2016/08/avatar-placeholder.gif" alt="User"/>
            </a>
        <ul class="dropdown-menu dropdown-menu-dark dropdown-menu-md-end" aria-labelledby="login">
          <li><a class="dropdown-item" href="/login">Login</a></li>
          <li><a class="dropdown-item" href="/signup">Signup</a></li>
        </ul>
        </div>
        <div class="nav-item dropdown pt-2 pt-md-0 ms-1">
            <div class="btn ${active.Cart}">
                <a href="/cart" id="login" role="button" aria-expanded="false">
                    <img class="rounded-circle" height="28px" src="/static/res/cartIcon.png" alt="Cart"/>
                </a>  
            </div>
        </div>
      </div>
    </div>
  </div>
</nav>`;
    }
}

class Footer extends HTMLElement {
    connectedCallback() {
        let attributes = this.attributes;
        const active = {Home: (attributes.Home?"active":""),
            Discounts: (attributes.Discounts?"active":""),
            Sell: (attributes.Sell?"active":""),
            Login: (attributes.Login?"active":"")}
        this.innerHTML=`
<nav class="shadow-sm navbar navbar-dark bg-dark">
  <div class="w-100">
    <div class="d-flex flex-column">
      <span class="text-success ms-2">© FCS Group, 2021</span>
      <rect class="mt-2 w-100 bg-warning" style="height: 1px"></rect>
      <ul class="mt-2 mx-2 navbar-nav d-flex flex-row justify-content-around flex-wrap">
        <li class="nav-item text-center" style="min-width: 150px">
          <a class="nav-link ${active.Home}" aria-current="page" href="/">Home</a>
        </li>
        <li class="nav-item text-center" style="min-width: 150px">
          <a class="nav-link ${active.Discounts}" href="/discounts">Discounts</a>
        </li>
        <li class="nav-item text-center" style="min-width: 150px">
          <a class="nav-link ${active.Sell}" href="/sell">Sell</a>
        </li>
        <li class="nav-item text-center" style="min-width: 150px">
          <a class="nav-link ${active.Login}" href="/login">Login</a>
        </li>
      </ul>
    </div>
  </div>
</nav>`;
    }
}
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
            <a href='item?id=${item.ID}/' style="text-decoration: inherit; color: inherit; cursor: auto;">
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
class Items extends HTMLElement {
    connectedCallback() {
        let args = this.attributes.args; // item object Take In Args And call FetchItems
        let itemList=FetchItems();
        this.innerHTML=`
<div class="card-deck d-flex flex-wrap mx-1 mx-sm-2 mx-md-3 mx-lg-4 py-3 justify-content-evenly">
    ${itemList.map((element)=>{return `<item-card ofItem='${JSON.stringify(element)}'></item-card>`}).join('')}
</div>`

    }
}
class MainItemDisplay extends HTMLElement {
    connectedCallback() {
        const item = FetchFullItem(new URL(window.location.href).searchParams.get("id"))
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
                    <div class="mb-md-2 h-100 mt-2 mt-md-4 px-2 px-md-0 ps-md-2 w-100 d-flex flex-column align-items-center justify-content-center" style="min-width: 300px">
                        <img class="card-img-top card-img rounded-0 rounded-top" style="max-width: 650px" src="${item.image}" alt="Card image cap">
                        <div class="w-100 d-flex flex-row justify-content-around flex-md-column">
                            <div class="card-footer d-flex flex-row align-items-center" style="max-height: 36px">
                                <small class="text-muted"><b>Price:</b></small>
                                <small class="ms-1">${item.price}</small>
                                <span style="font-size: 18px; font-weight: lighter">$</span>
                            </div>
                            <div class="card-footer d-flex flex-row align-items-center w-100" style="max-height: 36px">
                                <small class="text-muted"><b>Rating:</b> ${pos_rating}</small>
                                <span style="font-size: 24px">${neg_rating}</span>
                            </div>
                        </div>
                        <div class="w-100 d-flex flex-row justify-content-around flex-md-column">
                            <button class="btn btn-success mt-2 w-100">Add To Card</button>
                            <button class="btn btn-success mt-2 ms-2 ms-md-0 w-100">Checkout</button>
                        </div>
                    </div>
                    
                    
                    <div class="card-body pb-0">
                        <h1 class="card-title text-truncate">${item.title}</h1>
                        <p class="card-text pb-2">
                            ${item.description}
                        </p>
                    </div>
                    
            </div>
        </div>`

    }
}


customElements.define('nav-header', NavHeader);
customElements.define('nav-footer', Footer);
customElements.define('item-card', ItemCard);
customElements.define('items-display', Items);
customElements.define('main-item-display', MainItemDisplay);