<script>
  export let value;
  const mediaTypes = [
    { name: "Alle", key: "all" },
    { name: "Artikel", key: "feed" },
    { name: "Podcasts", key: "podcasts" },
    { name: "Youtube", key: "youtube" },
    { name: "Andere", key: "reddit,facebook" }
  ];
</script>

<div class="media-type-wrapper">
  Medientyp
  <div>
    {#each mediaTypes as type}
      <button
        class:btn-primary={value == type.key}
        class="btn btn-default btn-xs trend"
        on:click={e => (value = type.key)}>
        {type.name}
      </button>
    {/each}
  </div>
</div>
