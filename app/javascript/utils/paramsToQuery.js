export default function(params) {
  return Object.keys(params)
    .filter(k => params[k] !== null || params[k] != undefined)
    .map(k => `${encodeURIComponent(k)}=${encodeURIComponent(params[k])}`)
    .join("&");
}
