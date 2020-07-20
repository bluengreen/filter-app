<script>
  export let value;
  let categories = [];

  async function fetchCategories() {
    const r = await fetch(`/api/v1/categories.json`);
    categories = (await r.json()).categories;
  }
  fetchCategories();
</script>

<div class="trend-wrapper">
  Kategorien
  <div>
    {#each categories as category}
      <button
        class:btn-primary={category == value}
        class="btn btn-default btn-xs trend"
        on:click={e => value = category}>
        {category.name}
      </button>
    {/each}
  </div>
</div>

<style>
  .trend {
    margin-right: 5px;
  }
  .trend-wrapper {
    max-width: 500px;
  }
</style>

