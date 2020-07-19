<script>
  export let value;
  let trendsWeek = [];
  let trendsMonth = [];
  let active = "month";
  $: trends = active == "week" ? [...trendsWeek] : [...trendsMonth];

  async function fetchTrends() {
    const r = await fetch(`/js/trends.json`);
    const data = await r.json();
    trendsWeek = data.week;
    trendsMonth = data.month;
    trends = trendsMonth;
  }
  fetchTrends();

  function selectTrend(trend) {
    value = trend;
  }
</script>

<style>
  .trend-wrapper :global(.panel) {
    width: 500px;
    margin-left: 20px;
    margin-right: 20px;
  }
  @media screen and (max-width: 1100px) {
    .trend-wrapper {
      display: block;
    }
    .trend-wrapper :global(.panel) {
      margin: auto;
      margin-bottom: 20px;
    }
  }
  .trend {
    margin-right: 5px;
  }
  .btn-link {
    padding: 0;
    vertical-align: top;
    border: 0;
  }
</style>

<div class="trend-wrapper">
  Trends
  {#if active == 'week'}
    <button class="btn-link btn" on:click={e => (active = 'month')}>
      der Woche
    </button>
  {:else}
    <button class="btn-link btn" on:click={e => (active = 'week')}>
      des Monats
    </button>
  {/if}
  <div>
    {#each trends as trend}
      <button
        class:btn-primary={trend == value}
        class="btn btn-default btn-xs trend"
        on:click={e => selectTrend(trend)}>
        {trend.name}
      </button>
    {/each}
  </div>
</div>
