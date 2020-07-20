<script>
  import paramsToQuery from "utils/paramsToQuery"
  import NewsItem from "./NewsItem.svelte"
  import OrderDropdown from "./OrderDropdown.svelte"
  import MediaType from "./MediaType.svelte"
  import Trends from "./Trends.svelte"
  import SvelteInfiniteScroll from "svelte-infinite-scroll/src/lib/InfiniteScroll.svelte"
  import Categories from "./Categories.svelte"
  import watcher from "./watcher"

  let page = 1
  let hasMore = false
  let items = []
  let order = watcher("hot_score", () => (page = 1))
  let selectedTrend = watcher(null, () => {
    page = 1
    if ($selectedCategory) {
      $selectedCategory = null
    }
  })
  let selectedCategory = watcher(null, () => {
    page = 1
    if ($selectedTrend) {
      $selectedTrend = null
    }
  })
  let query
  let isLoading = true
  let viewStyle = "tiles"
  let mediaType = watcher("all", () => (page = 1))
  let loadEndlessly = false

  $: query = paramsToQuery({
    page,
    categories: $selectedCategory ? $selectedCategory.id : null,
    order: $order,
    mediatype: $mediaType,
    trend: $selectedTrend ? $selectedTrend.slug : null,
  })

  async function refetch() {
    isLoading = true
    console.log(`Fetch ${query}`)
    const r = await fetch(`/api/v1/news_items.json?${query}`, {
      credentials: "same-origin",
    })
    const json = await r.json()
    isLoading = false
    hasMore = json.meta.current_page < json.meta.pages
    if (page > 1) {
      items = [...items, ...json.news_items]
    } else {
      items = json.news_items
    }
  }
  $: {
    query && refetch()
  }
</script>

<div class="filter-bar">
  <div class="row">
    <div class="col-md-4 col-sm-6">
      <Trends bind:value={$selectedTrend} />
    </div>
    <div class="col-md-4 col-sm-6">
      <Categories bind:value={$selectedCategory} />
    </div>
    <div class="col-md-2 col-sm-6">
      <MediaType bind:value={$mediaType} />
    </div>
    <div class="col-md-2 text-right col-sm-6">
      <OrderDropdown bind:value={$order} />
      <div class="btn-group">
        <button
          on:click={e => (viewStyle = 'list')}
          title="Listenansicht"
          class="btn btn-default btn-xs"
          class:active={viewStyle == 'list'}>
          <i class="fa fa-fw fa-bars" />
        </button>
        <button
          on:click={e => (viewStyle = 'tiles')}
          title="Kachelansicht"
          class="btn btn-default btn-xs"
          class:active={viewStyle == 'tiles'}>
          <i class="fa fa-fw fa-th-large" />
        </button>
      </div>
    </div>
  </div>
</div>
{#if isLoading}
  <div class="text-center loading-indicator">Wird geladen..</div>
{:else if items.length == 0}
  <div class="container no-results">
    <div class="text-center">Keine Ergebnisse</div>
  </div>
{/if}
<div class="news-items--wrapper news-items--{viewStyle}">
  {#each items as item (item.id)}
    <NewsItem {item} {viewStyle} />
  {/each}
  {#if loadEndlessly}
    <SvelteInfiniteScroll
      threshold={100}
      on:loadMore={() => console.log('MORE') || page++}
      {hasMore}
      window={true} />
  {:else if hasMore}
    <div class="text-center">
      <button class="btn btn-primary" on:click={e => (loadEndlessly = true)}>
        Nachladen aktivieren
      </button>
    </div>
  {/if}
</div>

<style>
  .filter-bar {
    background: #333;
    color: white;
    padding: 15px 30px;
  }
  .loading-indicator {
    position: absolute;
    font-size: 30px;
    z-index: 200;
    width: 100%;
    height: 80vh;
    background: rgba(0, 0, 0, 0.5);
    color: #eee;
    padding-top: 50px;
  }
  .no-results {
    padding-top: 50px;
    font-size: 25px;
    color: #666;
  }
  @media screen and (max-width: 800px) {
    .col-sm-6 {
      text-align: left;
      margin-bottom: 20px;
    }
  }
</style>
