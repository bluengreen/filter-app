<script>
  import paramsToQuery from 'utils/paramsToQuery'
  import NewsItem from "./NewsItem.svelte";
  import Trends from "./Trends.svelte";

  let page = 1;
  let hasMore = false;
  let items = [];
  let selectedTrend = null;
  let query;
  let isLoading = true
  let viewStyle = 'tiles'

  $: query = paramsToQuery({
    page,
    trend: selectedTrend ? selectedTrend.slug : null,
    order: "hot_score"
  });

  async function refetch() {
    isLoading = true
    console.log(`Fetch ${query}`)
    const r = await fetch(`/api/v1/news_items.json?${query}`, {
      credentials: "same-origin"
    });
    const json = await r.json();
    isLoading = false
    hasMore = json.meta.current_page < json.meta.pages;
    items = json.news_items;
  }
  $: {
    query && refetch()
  }


</script>

<style>
  .news-items--wrapper {
    display: flex;
    flex-wrap: wrap;
    justify-content: space-around;
    opacity: 1;
    transition: opacity 0.3s ease-in;
    margin-top: 30px;
  }
  .news-items--wrapper :global(.news-item-panel) {
    width: 320px;
    margin-right: 5px;
    margin-left: 5px;
  }
  .filter-bar {
    background: #333;
    color: white;
    padding: 15px 30px;
  }
  .loading-indicator {
    position: absolute;
  }
</style>

<div class="filter-bar">
  <Trends bind:value={selectedTrend} />
  <div>
    <span on:click={e => viewStyle = 'list'}>Liste</span>
    <span on:click={e => viewStyle = 'tiles'}>Tiles</span>
  </div>
</div>
{#if isLoading }
  <div class='text-center loading-indicator'>
    Wird geladen..
  </div>
{/if}
<div class="news-items--wrapper">
  {#each items as item (item.id)}
    <NewsItem {item} {viewStyle}/>
  {/each}
</div>
