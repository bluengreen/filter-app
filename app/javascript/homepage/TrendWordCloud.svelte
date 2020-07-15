<script>
  import { onMount } from "svelte";

  import Wordcloud from "./../../../vendor/assets/javascripts/wordcloud_fork.js";
  export let trends = [];
  let canvas;
  let height;

  $: {
    if (trends.length < 10) {
      height = 120;
    } else if (trends.length < 20) {
      height = 200;
    } else {
      height = 300;
    }
  }
  $: max = Math.max.apply(null, trends.map(e => e.count));

  const createCloud = () => {
    if (!canvas) return;
    const list = trends.map(t => [t.name, t.count, t.slug]);
    Wordcloud(canvas, {
      list,
      gridSize: 13,
      createTextElement(item) {
        const w = document.createElement("a");
        const slug = item[2];
        w.href = `/trends/${slug}`;
        w.target = "_blank";
        return w;
      },
      color(word, weight, _fontSize, _distance, _theta) {
        const percent = (weight * 100) / max;
        return `hsl(233, ${80 - percent * 0.5}%, ${90 - percent * 0.8}%)`;
      },
      shape: "triangle-forward",
      weightFactor: 2
    });
  };
  $: createCloud(trends);
</script>

<style>
  .word-cloud--html-canvas {
    margin-bottom: 25px;
    width: auto;
    min-width: 300px;
  }
  .word-cloud--html-canvas :global(a) {
    opacity: 0.8;
    transition: all 0.1s ease-out;
    cursor: pointer;
  }
  .word-cloud--html-canvas :global(a:hover) {
    opacity: 1;
    text-decoration: none;
  }
</style>

<div
  class="word-cloud--html-canvas"
  style="height: {height}px"
  bind:this={canvas} />
