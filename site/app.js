const POOL_ADDRESS = "EQAJTo3VcLriSaMj-HdTzeEX6NJoQCyzG59bdvMW0k9956WX";
const API_URL = `https://api.ston.fi/v1/pools/${POOL_ADDRESS}`;

const fallback = {
  gram: 5.000000027,
  bluex: 6960.185222757,
};

const els = {
  priceGram: document.getElementById("priceGram"),
  poolRatio: document.getElementById("poolRatio"),
  gramReserve: document.getElementById("gramReserve"),
  bluexReserve: document.getElementById("bluexReserve"),
  liveStatus: document.getElementById("liveStatus"),
  copyContract: document.getElementById("copyContract"),
  contractAddress: document.getElementById("contractAddress"),
  year: document.getElementById("year"),
};

function format(value, digits = 6) {
  return new Intl.NumberFormat("en-US", {
    maximumFractionDigits: digits,
    minimumFractionDigits: 0,
  }).format(value);
}

function renderPool(gram, bluex, live) {
  if (!Number.isFinite(gram) || !Number.isFinite(bluex) || gram <= 0 || bluex <= 0) return;

  const bluexPerGram = bluex / gram;
  const gramPerBluex = gram / bluex;

  els.priceGram.textContent = `${gramPerBluex.toFixed(8)} GRAM`;
  els.poolRatio.textContent = `${format(bluexPerGram, 2)} BLUEX`;
  els.gramReserve.textContent = format(gram, 6);
  els.bluexReserve.textContent = format(bluex, 4);
  els.liveStatus.innerHTML = `<span></span> ${live ? "Live from STON.fi" : "Latest on-chain snapshot"}`;
  els.liveStatus.classList.toggle("is-live", live);
}

async function refreshPool() {
  try {
    const response = await fetch(API_URL, { cache: "no-store" });
    if (!response.ok) throw new Error(`STON API ${response.status}`);
    const data = await response.json();
    const pool = data.pool;
    if (!pool) throw new Error("Pool not returned");

    const gram = Number(pool.reserve0) / 1e9;
    const bluex = Number(pool.reserve1) / 1e9;
    renderPool(gram, bluex, true);
  } catch (error) {
    console.warn("Live pool refresh failed; showing fallback snapshot.", error);
    renderPool(fallback.gram, fallback.bluex, false);
  }
}

async function copyContract() {
  const text = els.contractAddress.textContent.trim();
  try {
    await navigator.clipboard.writeText(text);
  } catch {
    const area = document.createElement("textarea");
    area.value = text;
    area.style.position = "fixed";
    area.style.opacity = "0";
    document.body.appendChild(area);
    area.select();
    document.execCommand("copy");
    area.remove();
  }

  const original = els.copyContract.textContent;
  els.copyContract.textContent = "Copied";
  setTimeout(() => { els.copyContract.textContent = original; }, 1500);
}

els.copyContract?.addEventListener("click", copyContract);
els.year.textContent = new Date().getFullYear();

renderPool(fallback.gram, fallback.bluex, false);
refreshPool();
setInterval(refreshPool, 30000);
