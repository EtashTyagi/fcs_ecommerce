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

customElements.define('nav-footer', Footer);