<img width="300" height="144" alt="fifa_lakehouse_architecture" src="https://github.com/user-attachments/assets/80fc7cf3-16c3-4915-9dbe-3854479faf3c" /># FIFA Analytics Lakehouse

An end-to-end data lakehouse pipeline built on **Databricks** and **dbt**, transforming the [European Soccer Database](https://www.kaggle.com/datasets/hugomathien/soccer) (Kaggle) into analytics-ready dimensional models — including a **Slowly Changing Dimension (SCD Type 2)** for tracking player rating history over time.

![Architecture Diagram]![Upload<svg viewBox="0 0 1000 480" xmlns="http://www.w3.org/2000/svg" role="img" style="">
<title style="fill:rgb(0, 0, 0);stroke:none;color:rgb(255, 255, 255);stroke-width:1px;stroke-linecap:butt;stroke-linejoin:miter;opacity:1;font-family:&quot;Anthropic Sans&quot;, -apple-system, BlinkMacSystemFont, &quot;Segoe UI&quot;, sans-serif;font-size:16px;font-weight:400;text-anchor:start;dominant-baseline:auto">FIFA Analytics Lakehouse Architecture</title>
<desc style="fill:rgb(0, 0, 0);stroke:none;color:rgb(255, 255, 255);stroke-width:1px;stroke-linecap:butt;stroke-linejoin:miter;opacity:1;font-family:&quot;Anthropic Sans&quot;, -apple-system, BlinkMacSystemFont, &quot;Segoe UI&quot;, sans-serif;font-size:16px;font-weight:400;text-anchor:start;dominant-baseline:auto">Data flows from Kaggle SQLite source through Unity Catalog Volume, into Bronze, Silver, and Gold Delta Lake layers processed by PySpark and dbt, ending in a Databricks SQL dashboard. A parallel SCD Type 2 path tracks player rating history.</desc>

<defs>
  <marker id="arrow" markerWidth="8" markerHeight="8" refX="6" refY="3" orient="auto">
    <path d="M0,0 L6,3 L0,6 Z" fill="var(--text-secondary, #888)"/>
  </marker>
<mask id="imagine-text-gaps-ks8du3" maskUnits="userSpaceOnUse"><rect x="0" y="0" width="1000" height="480" fill="white"/><rect x="76" y="29.30419921875" width="56.69308090209961" height="14.869750022888184" fill="black" rx="2"/><rect x="265.9999694824219" y="29.30419921875" width="145.4513702392578" height="14.869750022888184" fill="black" rx="2"/><rect x="456" y="29.30419921875" width="56.13261032104492" height="14.869750022888184" fill="black" rx="2"/><rect x="636" y="29.30419921875" width="49.305049896240234" height="14.869750022888184" fill="black" rx="2"/><rect x="815.9999389648438" y="29.30419921875" width="40.830039978027344" height="14.869750022888184" fill="black" rx="2"/><rect x="54.34541702270508" y="71.04327392578125" width="51.691017150878906" height="19.217649459838867" fill="black" rx="2"/><rect x="26.78040313720703" y="90.21721649169922" width="107.05452728271484" height="15.956725120544434" fill="black" rx="2"/><rect x="231.8367156982422" y="71.04327392578125" width="76.70561981201172" height="19.217649459838867" fill="black" rx="2"/><rect x="230.18077087402344" y="90.21721649169922" width="79.82038879394531" height="15.956725120544434" fill="black" rx="2"/><rect x="433.9802551269531" y="71.04327392578125" width="52.407711029052734" height="19.217649459838867" fill="black" rx="2"/><rect x="416.3933410644531" y="90.21721649169922" width="87.40290832519531" height="15.956725120544434" fill="black" rx="2"/><rect x="618.3026733398438" y="71.04327392578125" width="44.851463317871094" height="19.217649459838867" fill="black" rx="2"/><rect x="600.7496948242188" y="90.21721649169922" width="79.1831283569336" height="15.956725120544434" fill="black" rx="2"/><rect x="794.9786987304688" y="71.04327392578125" width="70.05781936645508" height="19.217649459838867" fill="black" rx="2"/><rect x="780.864990234375" y="90.21721649169922" width="98.45954895019531" height="15.956725120544434" fill="black" rx="2"/><rect x="405.43017578125" y="152.30418395996094" width="109.2291259765625" height="14.869750022888184" fill="black" rx="2"/><rect x="589.3704223632812" y="152.30418395996094" width="101.34742736816406" height="14.869750022888184" fill="black" rx="2"/><rect x="784.2532958984375" y="152.30418395996094" width="91.64559173583984" height="14.869750022888184" fill="black" rx="2"/><rect x="701.1734619140625" y="251.04327392578125" width="178.03256225585938" height="19.217649459838867" fill="black" rx="2"/><rect x="691.7473754882812" y="270.2171936035156" width="197.35748291015625" height="15.956725120544434" fill="black" rx="2"/><rect x="718.03857421875" y="222.39117431640625" width="143.92282104492188" height="13.782774925231934" fill="black" rx="2"/><rect x="71.0362548828125" y="251.04327392578125" width="136.84622192382812" height="19.217649459838867" fill="black" rx="2"/><rect x="66.17035675048828" y="270.2171936035156" width="148.9249725341797" height="15.956725120544434" fill="black" rx="2"/><rect x="412.0226135253906" y="384.04327392578125" width="175.95462036132812" height="19.217649459838867" fill="black" rx="2"/><rect x="420.66748046875" y="404.21722412109375" width="158.85366821289062" height="15.956725120544434" fill="black" rx="2"/></mask></defs>



<!-- Stage labels -->
<text x="80" y="40" style="fill:rgb(170, 170, 170);stroke:none;color:rgb(255, 255, 255);stroke-width:1px;stroke-linecap:butt;stroke-linejoin:miter;opacity:1;font-family:-apple-system, sans-serif;font-size:10px;font-weight:700;text-anchor:start;dominant-baseline:auto">Source</text>
<text x="270" y="40" style="fill:rgb(170, 170, 170);stroke:none;color:rgb(255, 255, 255);stroke-width:1px;stroke-linecap:butt;stroke-linejoin:miter;opacity:1;font-family:-apple-system, sans-serif;font-size:10px;font-weight:700;text-anchor:start;dominant-baseline:auto">Storage (UC Volume)</text>
<text x="460" y="40" style="fill:rgb(170, 170, 170);stroke:none;color:rgb(255, 255, 255);stroke-width:1px;stroke-linecap:butt;stroke-linejoin:miter;opacity:1;font-family:-apple-system, sans-serif;font-size:10px;font-weight:700;text-anchor:start;dominant-baseline:auto">Bronze</text>
<text x="640" y="40" style="fill:rgb(170, 170, 170);stroke:none;color:rgb(255, 255, 255);stroke-width:1px;stroke-linecap:butt;stroke-linejoin:miter;opacity:1;font-family:-apple-system, sans-serif;font-size:10px;font-weight:700;text-anchor:start;dominant-baseline:auto">Silver</text>
<text x="820" y="40" style="fill:rgb(170, 170, 170);stroke:none;color:rgb(255, 255, 255);stroke-width:1px;stroke-linecap:butt;stroke-linejoin:miter;opacity:1;font-family:-apple-system, sans-serif;font-size:10px;font-weight:700;text-anchor:start;dominant-baseline:auto">Gold</text>

<!-- Source -->
<rect x="20" y="60" width="120" height="60" style="fill:rgb(247, 247, 249);stroke:rgb(221, 221, 221);color:rgb(255, 255, 255);stroke-width:1px;stroke-linecap:butt;stroke-linejoin:miter;opacity:1;font-family:&quot;Anthropic Sans&quot;, -apple-system, BlinkMacSystemFont, &quot;Segoe UI&quot;, sans-serif;font-size:16px;font-weight:400;text-anchor:start;dominant-baseline:auto"/>
<text x="80" y="85" text-anchor="middle" style="fill:rgb(34, 34, 34);stroke:none;color:rgb(255, 255, 255);stroke-width:1px;stroke-linecap:butt;stroke-linejoin:miter;opacity:1;font-family:-apple-system, sans-serif;font-size:13px;font-weight:700;text-anchor:middle;dominant-baseline:auto">Kaggle</text>
<text x="80" y="102" text-anchor="middle" style="fill:rgb(119, 119, 119);stroke:none;color:rgb(255, 255, 255);stroke-width:1px;stroke-linecap:butt;stroke-linejoin:miter;opacity:1;font-family:-apple-system, sans-serif;font-size:10.5px;font-weight:400;text-anchor:middle;dominant-baseline:auto">European Soccer DB</text>

<!-- Volume -->
<rect x="200" y="60" width="140" height="60" style="fill:rgb(247, 247, 249);stroke:rgb(221, 221, 221);color:rgb(255, 255, 255);stroke-width:1px;stroke-linecap:butt;stroke-linejoin:miter;opacity:1;font-family:&quot;Anthropic Sans&quot;, -apple-system, BlinkMacSystemFont, &quot;Segoe UI&quot;, sans-serif;font-size:16px;font-weight:400;text-anchor:start;dominant-baseline:auto"/>
<text x="270" y="85" text-anchor="middle" style="fill:rgb(34, 34, 34);stroke:none;color:rgb(255, 255, 255);stroke-width:1px;stroke-linecap:butt;stroke-linejoin:miter;opacity:1;font-family:-apple-system, sans-serif;font-size:13px;font-weight:700;text-anchor:middle;dominant-baseline:auto">UC Volume</text>
<text x="270" y="102" text-anchor="middle" style="fill:rgb(119, 119, 119);stroke:none;color:rgb(255, 255, 255);stroke-width:1px;stroke-linecap:butt;stroke-linejoin:miter;opacity:1;font-family:-apple-system, sans-serif;font-size:10.5px;font-weight:400;text-anchor:middle;dominant-baseline:auto">7 raw CSV files</text>

<!-- Bronze -->
<rect x="400" y="60" width="120" height="60" stroke="#cd7f32" stroke-width="1.5" style="fill:rgb(247, 247, 249);stroke:rgb(221, 221, 221);color:rgb(255, 255, 255);stroke-width:1px;stroke-linecap:butt;stroke-linejoin:miter;opacity:1;font-family:&quot;Anthropic Sans&quot;, -apple-system, BlinkMacSystemFont, &quot;Segoe UI&quot;, sans-serif;font-size:16px;font-weight:400;text-anchor:start;dominant-baseline:auto"/>
<text x="460" y="85" text-anchor="middle" style="fill:rgb(34, 34, 34);stroke:none;color:rgb(255, 255, 255);stroke-width:1px;stroke-linecap:butt;stroke-linejoin:miter;opacity:1;font-family:-apple-system, sans-serif;font-size:13px;font-weight:700;text-anchor:middle;dominant-baseline:auto">Bronze</text>
<text x="460" y="102" text-anchor="middle" style="fill:rgb(119, 119, 119);stroke:none;color:rgb(255, 255, 255);stroke-width:1px;stroke-linecap:butt;stroke-linejoin:miter;opacity:1;font-family:-apple-system, sans-serif;font-size:10.5px;font-weight:400;text-anchor:middle;dominant-baseline:auto">Raw Delta tables</text>

<!-- Silver -->
<rect x="580" y="60" width="120" height="60" stroke="#9e9e9e" stroke-width="1.5" style="fill:rgb(247, 247, 249);stroke:rgb(221, 221, 221);color:rgb(255, 255, 255);stroke-width:1px;stroke-linecap:butt;stroke-linejoin:miter;opacity:1;font-family:&quot;Anthropic Sans&quot;, -apple-system, BlinkMacSystemFont, &quot;Segoe UI&quot;, sans-serif;font-size:16px;font-weight:400;text-anchor:start;dominant-baseline:auto"/>
<text x="640" y="85" text-anchor="middle" style="fill:rgb(34, 34, 34);stroke:none;color:rgb(255, 255, 255);stroke-width:1px;stroke-linecap:butt;stroke-linejoin:miter;opacity:1;font-family:-apple-system, sans-serif;font-size:13px;font-weight:700;text-anchor:middle;dominant-baseline:auto">Silver</text>
<text x="640" y="102" text-anchor="middle" style="fill:rgb(119, 119, 119);stroke:none;color:rgb(255, 255, 255);stroke-width:1px;stroke-linecap:butt;stroke-linejoin:miter;opacity:1;font-family:-apple-system, sans-serif;font-size:10.5px;font-weight:400;text-anchor:middle;dominant-baseline:auto">Cleaned, typed</text>

<!-- Gold -->
<rect x="760" y="60" width="140" height="60" stroke="#e0b84c" stroke-width="1.5" style="fill:rgb(247, 247, 249);stroke:rgb(221, 221, 221);color:rgb(255, 255, 255);stroke-width:1px;stroke-linecap:butt;stroke-linejoin:miter;opacity:1;font-family:&quot;Anthropic Sans&quot;, -apple-system, BlinkMacSystemFont, &quot;Segoe UI&quot;, sans-serif;font-size:16px;font-weight:400;text-anchor:start;dominant-baseline:auto"/>
<text x="830" y="85" text-anchor="middle" style="fill:rgb(34, 34, 34);stroke:none;color:rgb(255, 255, 255);stroke-width:1px;stroke-linecap:butt;stroke-linejoin:miter;opacity:1;font-family:-apple-system, sans-serif;font-size:13px;font-weight:700;text-anchor:middle;dominant-baseline:auto">Gold (dbt)</text>
<text x="830" y="102" text-anchor="middle" style="fill:rgb(119, 119, 119);stroke:none;color:rgb(255, 255, 255);stroke-width:1px;stroke-linecap:butt;stroke-linejoin:miter;opacity:1;font-family:-apple-system, sans-serif;font-size:10.5px;font-weight:400;text-anchor:middle;dominant-baseline:auto">dims + facts + tests</text>

<!-- Arrows row 1 -->
<path d="M140,90 L198,90" style="fill:none;stroke:rgb(170, 170, 170);color:rgb(255, 255, 255);stroke-width:1.5px;stroke-linecap:butt;stroke-linejoin:miter;opacity:1;font-family:&quot;Anthropic Sans&quot;, -apple-system, BlinkMacSystemFont, &quot;Segoe UI&quot;, sans-serif;font-size:16px;font-weight:400;text-anchor:start;dominant-baseline:auto"/>
<path d="M340,90 L398,90" style="fill:none;stroke:rgb(170, 170, 170);color:rgb(255, 255, 255);stroke-width:1.5px;stroke-linecap:butt;stroke-linejoin:miter;opacity:1;font-family:&quot;Anthropic Sans&quot;, -apple-system, BlinkMacSystemFont, &quot;Segoe UI&quot;, sans-serif;font-size:16px;font-weight:400;text-anchor:start;dominant-baseline:auto"/>
<path d="M520,90 L578,90" style="fill:none;stroke:rgb(170, 170, 170);color:rgb(255, 255, 255);stroke-width:1.5px;stroke-linecap:butt;stroke-linejoin:miter;opacity:1;font-family:&quot;Anthropic Sans&quot;, -apple-system, BlinkMacSystemFont, &quot;Segoe UI&quot;, sans-serif;font-size:16px;font-weight:400;text-anchor:start;dominant-baseline:auto"/>
<path d="M700,90 L758,90" style="fill:none;stroke:rgb(170, 170, 170);color:rgb(255, 255, 255);stroke-width:1.5px;stroke-linecap:butt;stroke-linejoin:miter;opacity:1;font-family:&quot;Anthropic Sans&quot;, -apple-system, BlinkMacSystemFont, &quot;Segoe UI&quot;, sans-serif;font-size:16px;font-weight:400;text-anchor:start;dominant-baseline:auto"/>

<!-- Tools row -->
<rect x="395" y="140" width="130" height="36" rx="6" fill="#2d6a4f" style="fill:rgb(45, 106, 79);stroke:none;color:rgb(255, 255, 255);stroke-width:1px;stroke-linecap:butt;stroke-linejoin:miter;opacity:1;font-family:&quot;Anthropic Sans&quot;, -apple-system, BlinkMacSystemFont, &quot;Segoe UI&quot;, sans-serif;font-size:16px;font-weight:400;text-anchor:start;dominant-baseline:auto"/>
<text x="460" y="163" text-anchor="middle" style="fill:rgb(255, 255, 255);stroke:none;color:rgb(255, 255, 255);stroke-width:1px;stroke-linecap:butt;stroke-linejoin:miter;opacity:1;font-family:-apple-system, sans-serif;font-size:9.5px;font-weight:600;text-anchor:middle;dominant-baseline:auto">PySpark (Bronze load)</text>

<rect x="575" y="140" width="130" height="36" rx="6" fill="#2d6a4f" style="fill:rgb(45, 106, 79);stroke:none;color:rgb(255, 255, 255);stroke-width:1px;stroke-linecap:butt;stroke-linejoin:miter;opacity:1;font-family:&quot;Anthropic Sans&quot;, -apple-system, BlinkMacSystemFont, &quot;Segoe UI&quot;, sans-serif;font-size:16px;font-weight:400;text-anchor:start;dominant-baseline:auto"/>
<text x="640" y="163" text-anchor="middle" style="fill:rgb(255, 255, 255);stroke:none;color:rgb(255, 255, 255);stroke-width:1px;stroke-linecap:butt;stroke-linejoin:miter;opacity:1;font-family:-apple-system, sans-serif;font-size:9.5px;font-weight:600;text-anchor:middle;dominant-baseline:auto">PySpark (clean/type)</text>

<rect x="755" y="140" width="150" height="36" rx="6" fill="#7b2d8b" style="fill:rgb(123, 45, 139);stroke:none;color:rgb(255, 255, 255);stroke-width:1px;stroke-linecap:butt;stroke-linejoin:miter;opacity:1;font-family:&quot;Anthropic Sans&quot;, -apple-system, BlinkMacSystemFont, &quot;Segoe UI&quot;, sans-serif;font-size:16px;font-weight:400;text-anchor:start;dominant-baseline:auto"/>
<text x="830" y="163" text-anchor="middle" style="fill:rgb(255, 255, 255);stroke:none;color:rgb(255, 255, 255);stroke-width:1px;stroke-linecap:butt;stroke-linejoin:miter;opacity:1;font-family:-apple-system, sans-serif;font-size:9.5px;font-weight:600;text-anchor:middle;dominant-baseline:auto">dbt models + tests</text>

<!-- SCD2 branch -->
<path d="M640,120 L640,230 L830,230 L830,150" stroke-dasharray="4,3" mask="url(#imagine-text-gaps-ks8du3)" style="fill:none;stroke:rgb(170, 170, 170);color:rgb(255, 255, 255);stroke-width:1.5px;stroke-dasharray:4px, 3px;stroke-linecap:butt;stroke-linejoin:miter;opacity:1;font-family:&quot;Anthropic Sans&quot;, -apple-system, BlinkMacSystemFont, &quot;Segoe UI&quot;, sans-serif;font-size:16px;font-weight:400;text-anchor:start;dominant-baseline:auto"/>
<rect x="650" y="240" width="280" height="60" stroke="#1d3557" stroke-width="1.5" style="fill:rgb(247, 247, 249);stroke:rgb(221, 221, 221);color:rgb(255, 255, 255);stroke-width:1px;stroke-linecap:butt;stroke-linejoin:miter;opacity:1;font-family:&quot;Anthropic Sans&quot;, -apple-system, BlinkMacSystemFont, &quot;Segoe UI&quot;, sans-serif;font-size:16px;font-weight:400;text-anchor:start;dominant-baseline:auto"/>
<text x="790" y="265" text-anchor="middle" style="fill:rgb(34, 34, 34);stroke:none;color:rgb(255, 255, 255);stroke-width:1px;stroke-linecap:butt;stroke-linejoin:miter;opacity:1;font-family:-apple-system, sans-serif;font-size:13px;font-weight:700;text-anchor:middle;dominant-baseline:auto">dim_player_ratings_history</text>
<text x="790" y="282" text-anchor="middle" style="fill:rgb(119, 119, 119);stroke:none;color:rgb(255, 255, 255);stroke-width:1px;stroke-linecap:butt;stroke-linejoin:miter;opacity:1;font-family:-apple-system, sans-serif;font-size:10.5px;font-weight:400;text-anchor:middle;dominant-baseline:auto">SCD Type 2 (PySpark window functions)</text>
<text x="790" y="232" text-anchor="middle" style="font-size:9px;;fill:rgb(119, 119, 119);stroke:none;color:rgb(255, 255, 255);stroke-width:1px;stroke-linecap:butt;stroke-linejoin:miter;opacity:1;font-family:-apple-system, sans-serif;font-size:9px;font-weight:400;text-anchor:middle;dominant-baseline:auto">183K snapshots → validity ranges</text>

<!-- dbt snapshot branch -->
<rect x="20" y="240" width="240" height="60" stroke="#ff3621" stroke-width="1.5" style="fill:rgb(247, 247, 249);stroke:rgb(221, 221, 221);color:rgb(255, 255, 255);stroke-width:1px;stroke-linecap:butt;stroke-linejoin:miter;opacity:1;font-family:&quot;Anthropic Sans&quot;, -apple-system, BlinkMacSystemFont, &quot;Segoe UI&quot;, sans-serif;font-size:16px;font-weight:400;text-anchor:start;dominant-baseline:auto"/>
<text x="140" y="265" text-anchor="middle" style="fill:rgb(34, 34, 34);stroke:none;color:rgb(255, 255, 255);stroke-width:1px;stroke-linecap:butt;stroke-linejoin:miter;opacity:1;font-family:-apple-system, sans-serif;font-size:13px;font-weight:700;text-anchor:middle;dominant-baseline:auto">team_snapshot (dbt)</text>
<text x="140" y="282" text-anchor="middle" style="fill:rgb(119, 119, 119);stroke:none;color:rgb(255, 255, 255);stroke-width:1px;stroke-linecap:butt;stroke-linejoin:miter;opacity:1;font-family:-apple-system, sans-serif;font-size:10.5px;font-weight:400;text-anchor:middle;dominant-baseline:auto">SCD2 via dbt "check" strategy</text>
<path d="M260,270 L575,270 L575,158" stroke-dasharray="4,3" style="fill:none;stroke:rgb(170, 170, 170);color:rgb(255, 255, 255);stroke-width:1.5px;stroke-dasharray:4px, 3px;stroke-linecap:butt;stroke-linejoin:miter;opacity:1;font-family:&quot;Anthropic Sans&quot;, -apple-system, BlinkMacSystemFont, &quot;Segoe UI&quot;, sans-serif;font-size:16px;font-weight:400;text-anchor:start;dominant-baseline:auto"/>

<!-- Dashboard -->
<rect x="380" y="370" width="240" height="70" stroke="#FF9900" stroke-width="1.5" style="fill:rgb(247, 247, 249);stroke:rgb(221, 221, 221);color:rgb(255, 255, 255);stroke-width:1px;stroke-linecap:butt;stroke-linejoin:miter;opacity:1;font-family:&quot;Anthropic Sans&quot;, -apple-system, BlinkMacSystemFont, &quot;Segoe UI&quot;, sans-serif;font-size:16px;font-weight:400;text-anchor:start;dominant-baseline:auto"/>
<text x="500" y="398" text-anchor="middle" style="fill:rgb(34, 34, 34);stroke:none;color:rgb(255, 255, 255);stroke-width:1px;stroke-linecap:butt;stroke-linejoin:miter;opacity:1;font-family:-apple-system, sans-serif;font-size:13px;font-weight:700;text-anchor:middle;dominant-baseline:auto">Databricks SQL Dashboard</text>
<text x="500" y="416" text-anchor="middle" style="fill:rgb(119, 119, 119);stroke:none;color:rgb(255, 255, 255);stroke-width:1px;stroke-linecap:butt;stroke-linejoin:miter;opacity:1;font-family:-apple-system, sans-serif;font-size:10.5px;font-weight:400;text-anchor:middle;dominant-baseline:auto">Standings · Top players · Trends</text>

<path d="M830,176 L830,330 L500,330 L500,368" mask="url(#imagine-text-gaps-ks8du3)" style="fill:none;stroke:rgb(170, 170, 170);color:rgb(255, 255, 255);stroke-width:1.5px;stroke-linecap:butt;stroke-linejoin:miter;opacity:1;font-family:&quot;Anthropic Sans&quot;, -apple-system, BlinkMacSystemFont, &quot;Segoe UI&quot;, sans-serif;font-size:16px;font-weight:400;text-anchor:start;dominant-baseline:auto"/>
<path d="M790,300 L790,330" opacity="0" style="fill:none;stroke:rgb(170, 170, 170);color:rgb(255, 255, 255);stroke-width:1.5px;stroke-linecap:butt;stroke-linejoin:miter;opacity:0;font-family:&quot;Anthropic Sans&quot;, -apple-system, BlinkMacSystemFont, &quot;Segoe UI&quot;, sans-serif;font-size:16px;font-weight:400;text-anchor:start;dominant-baseline:auto"/>

</svg>ing fifa_lakehouse_architecture.svg…]())

## Overview

This project implements a **medallion (bronze/silver/gold) architecture**:

- **Bronze** — raw CSV data (extracted from a SQLite source) loaded into Delta tables, schema as-is
- **Silver** — cleaned, type-cast, deduplicated tables with irrelevant columns dropped
- **Gold** — dimensional model (star schema) built with **dbt**: dimension tables, a fact table, and a player rating history table modeled as **SCD Type 2**

The dataset covers ~25,000 European football matches and ~11,000 players across 11 leagues from 2008–2016, including 183K player attribute snapshots used to build the rating history dimension.

## Tech Stack

| Layer | Tool |
|---|---|
| Compute & storage | Databricks (Free Edition), Unity Catalog Volumes, Delta Lake |
| Ingestion & cleaning | PySpark |
| Transformation & testing | dbt (dbt-databricks adapter) |
| SCD Type 2 | PySpark window functions (historical) + dbt snapshot (live, "check" strategy) |
| Visualization | Databricks SQL dashboard |

## Architecture

```
Kaggle (SQLite) 
    -> extract_sqlite_to_csv.py (Python)
    -> Unity Catalog Volume (raw CSVs)
    -> Bronze Delta tables (PySpark, schema inference)
    -> Silver Delta tables (PySpark, cleaned & typed)
    -> Gold dbt models (staging -> dims/facts, tested)
    -> Databricks SQL Dashboard
```

A parallel branch derives `dim_player_ratings_history` — an SCD Type 2 table built from 183K dated player-attribute snapshots using `lead()` window functions to compute `valid_from` / `valid_to` / `is_current` ranges.

## Data Model (Gold Layer)

| Table | Type | Description |
|---|---|---|
| `dim_player` | Dimension | Player biographical info (name, birthday, height, weight) |
| `dim_team` | Dimension | Team names |
| `dim_league` | Dimension | League joined with country |
| `fct_match_results` | Fact | One row per match: teams, scores, result, goal difference |
| `dim_player_ratings_history` | SCD Type 2 | Player rating/attribute history with validity ranges |
| `team_snapshot` | dbt snapshot | Demonstrates dbt-native SCD2 ("check" strategy) on team data |

## SCD Type 2: Two Approaches

This project demonstrates both common patterns for Slowly Changing Dimensions:

1. **Historical data → SCD2 (PySpark)**: `silver_player_attributes` contains 183K dated snapshots of player ratings. Using `Window.partitionBy("player_api_id").orderBy("date")` and `lead()`, each snapshot is converted into a validity range (`valid_from`, `valid_to`, `is_current`). This is the correct approach when you already have historical, dated records.

2. **Live data → SCD2 (dbt snapshot)**: `team_snapshot` uses dbt's snapshot feature with a `check` strategy on `team_long_name` and `team_short_name`. This is the correct approach for a *mutable* source table where you want to capture changes going forward each time the snapshot runs.

## Data Quality

11 dbt tests covering uniqueness, null checks, referential integrity (match teams exist in `dim_team`), and accepted values (`result` in `HOME_WIN`/`AWAY_WIN`/`DRAW`) — all passing.

## Dashboard

A Databricks SQL dashboard with 4 visualizations:
- **Team standings** by season (wins/draws/losses, goals, points)
- **Top 10 players** by current overall rating
- **Player rating progression** over time (e.g. Lionel Messi's rating vs. potential, 2008–2016)
- **Goals-per-match trend** across seasons

<img width="1342" height="527" alt="Player rating progression overtime - Messi" src="https://github.com/user-attachments/assets/e6080145-5bca-4669-aa95-93bb84953e92" />
<img width="1322" height="596" alt="Goals trend per season" src="https://github.com/user-attachments/assets/53224227-0868-49ec-aaaf-bdece7036ae5" />
<img width="1324" height="555" alt="Top 10 Current Players by Overall rating" src="https://github.com/user-attachments/assets/cc73e9ac-48c5-477e-9eae-331b58f1eb14" />
<img width="1315" height="633" alt="Team Standings by Season" src="https://github.com/user-attachments/assets/0a584c59-47af-4f0f-944c-c39e00d16755" />


## Project Structure

```
.
├── extract_sqlite_to_csv.py     # Extracts Kaggle SQLite tables to CSV
├── 02_bronze_layer.py           # Databricks notebook: raw CSV -> Bronze Delta
├── 03_silver_layer.py           # Databricks notebook: clean & type -> Silver Delta
├── 04_gold_layer.py             # Databricks notebook: dims/facts + SCD2 (PySpark)
├── 05_dashboard_queries.sql     # SQL for the Databricks SQL dashboard
├── architecture_diagram.svg
└── fifa_dbt_project/
    ├── dbt_project.yml
    ├── models/
    │   ├── staging/             # 1:1 views over Silver tables
    │   └── marts/               # dim_player, dim_team, dim_league, fct_match_results + tests
    └── snapshots/
        └── team_snapshot.sql    # dbt-native SCD2 demo
```

## How to Run

1. **Extract data**: run `extract_sqlite_to_csv.py` against the Kaggle `database.sqlite` file
2. **Upload** the resulting CSVs to a Unity Catalog Volume in Databricks
3. **Run notebooks in order**: `02_bronze_layer.py` → `03_silver_layer.py` → `04_gold_layer.py`
4. **Run dbt**:
   ```bash
   cd fifa_dbt_project
   dbt run
   dbt test
   dbt snapshot
   ```
5. **Build the dashboard** using the queries in `05_dashboard_queries.sql`

## Future Improvements

- Add a parameterized player search to the dashboard
- Extend `fct_match_results` with betting odds columns for predictive modeling
- Schedule the pipeline with Databricks Workflows for daily/weekly refresh
- Migrate raw storage from Unity Catalog Volumes to S3/ADLS via external locations for production-style cloud storage
