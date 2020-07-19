<script>
  export let value;

  let open = false
  const orderOptions = {
    all_best: "Beste",
    newest: "Neuste",
    week_best: "Top 30% je Woche",
    month_best: "Top 30% je Monat",
    hot_score: "Hot",
  }

  const select = (key) => {
    open = false
    value = key
  }
</script>


<!-- svelte-ignore a11y-invalid-attribute -->
<div class="btn-group" class:open={open}>
  <button type="button" class="btn btn-xs btn-default dropdown-toggle" aria-haspopup="true" aria-expanded="false" on:click={e => open = !open }>
    <i class="fa fa-sort-amount-desc" aria-hidden="true"></i>
    {orderOptions[value]}
    <span class="caret"></span>
  </button>
  <ul class="dropdown-menu">
    {#each Object.entries(orderOptions) as [key, name] }
      <li class:active={key == value}>
        <a href="#" on:click|preventDefault={e => select(key) }>
          {name}
        </a>
      </li>
    {/each}
  </ul>
</div>
