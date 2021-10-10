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

customElements.define('nav-header', NavHeader);