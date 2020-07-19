<script>
  export let item;
  export let viewStyle = "tiles";
  import truncate from "utils/truncate-filter";

  let lsr = item.source.lsr_active;
  let hasImage = item.image && item.image.full_url && !lsr;
  let url = item.url.split("?")[0];

  const date = () => {
    const d = new Date(Date.parse(item.published_at));
    const today = new Date();
    const month = [
      "Jan",
      "Feb",
      "Mar",
      "Apr",
      "Mai",
      "Jun",
      "Jul",
      "Aug",
      "Sep",
      "Okt",
      "Nov",
      "Dez"
    ][d.getMonth()];
    let s = `${d.getDate()}. ${month}`;
    if (d.getFullYear() !== today.getFullYear()) {
      s += " " + d.getFullYear();
    }
    return s;
  };
</script>

<style>
  .panel-footer {
    padding: 2px;
  }
  .label-warning {
    display: inline-block;
    height: 15px;
    border-radius: 5px;
  }
</style>

{#if viewStyle == 'tiles'}
  <div class="panel panel-default news-item-panel">
    <div class="panel-heading">
      <h3 class="panel-title">
        <a href={url} target="_blank" rel="noopener" title={item.title}>
          {truncate(item.title, 100)}
        </a>
      </h3>
    </div>
    <div class="panel-body" class:with-background={hasImage}>
      {#if hasImage}
        <div class="background-frame">
          <img class="background" src={item.image.full_url} alt="Teaser Foto" />
        </div>
      {/if}
      <div class="background-text">
        <p class="source" />
        {#if !lsr && item.teaser}{item.teaser}{/if}
      </div>
      <div class="fog-fade" />
    </div>
    <div class="panel-footer">
      <span class="pull-right text-muted">
        {#if item.paywall}
          <span class="label label-warning">
            <i class="fa fa-euro fa-fw" title="Paywall" ></i>
          </span>
        {/if}
        {date()}
      </span>
      <span class="source">
        {#if item.source.logo}
          <img src={item.source.logo} width="16" height="16" alt="Logo" />
        {/if}
        <a title={item.source.name} href={item.source.url}>
          {truncate(item.source.name, 30)}
        </a>
      </span>
    </div>
  </div>

{:else}

  <div class="news-item__list-item">
    <div>
      <h3><a href={url} target="_blank" rel="noopener" title={item.title}>
          {truncate(item.title, 130)}
      </a></h3>
      <span class="source">
        {#if item.source.logo}
          <img src={item.source.logo} width="16" height="16" alt="Logo" />
        {/if}
        <a title={item.source.name} href={item.source.url}>
          {truncate(item.source.name, 30)}
        </a>
      </span>
    </div>

    <div>
      {#if item.paywall}
        <span class="label label-warning">
          <i class="fa fa-euro fa-fw" title="Paywall" ></i>
        </span>
      {/if}
      {#if hasImage}
        <div class="background-frame">
          <img class="background" src={item.image.full_url} alt="Teaser Foto" />
        </div>
      {/if}
    </div>
  </div>
{/if}
