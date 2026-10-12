<?xml version="1.0" ?>
<mxfile host="app.diagrams.net" modified="2026-10-12T16:20:00.000Z" agent="Perplexity Enterprise Architecture" version="24.7.17" type="device" compressed="false">
  <diagram id="runtime-delta-flow" name="1 - Runtime Delta Flow">
    <mxGraphModel dx="1900" dy="1180" grid="1" gridSize="10" guides="1" tooltips="1" connect="1" arrows="1" fold="1" page="1" pageScale="1" pageWidth="1900" pageHeight="1180" math="0" shadow="0">
      <root>
        <mxCell id="0"/>
        <mxCell id="1" parent="0"/>
        <mxCell id="t1" value="Vendor-Triggered Delta Streaming — Runtime Swimlane" style="text;html=1;align=left;verticalAlign=middle;fontSize=28;fontStyle=1;fontColor=#102A43;" parent="1" vertex="1">
          <mxGeometry as="geometry" x="40" y="15" width="1500" height="45"/>
        </mxCell>
        <mxCell id="t2" value="Your company owns Amazon MSK; Cohere Health or another vendor consumes an authorized delta at its own pace." style="text;html=1;align=left;fontSize=15;fontColor=#536B7D;" parent="1" vertex="1">
          <mxGeometry as="geometry" x="42" y="60" width="1500" height="28"/>
        </mxCell>
        <mxCell id="lane1" value="YOUR COMPANY — DOMAIN / DATA OWNER" style="swimlane;html=1;horizontal=0;startSize=42;fillColor=#0798B5;swimlaneFillColor=#F8FBFC;fontColor=#FFFFFF;fontStyle=1;fontSize=13;rounded=0;collapsible=0;separatorColor=#D5E4E9;strokeColor=#A8C6D0;" parent="1" vertex="1">
          <mxGeometry as="geometry" x="40" y="100" width="1810" height="210"/>
        </mxCell>
        <mxCell id="lane2" value="YOUR COMPANY — MSK PLATFORM PRODUCT" style="swimlane;html=1;horizontal=0;startSize=42;fillColor=#1E293B;swimlaneFillColor=#F8FBFC;fontColor=#FFFFFF;fontStyle=1;fontSize=13;rounded=0;collapsible=0;separatorColor=#D5E4E9;strokeColor=#A8C6D0;" parent="1" vertex="1">
          <mxGeometry as="geometry" x="40" y="330" width="1810" height="210"/>
        </mxCell>
        <mxCell id="lane3" value="VENDOR EDGE — CONNECTIVITY / CONSUMER" style="swimlane;html=1;horizontal=0;startSize=42;fillColor=#2563EB;swimlaneFillColor=#F8FBFC;fontColor=#FFFFFF;fontStyle=1;fontSize=13;rounded=0;collapsible=0;separatorColor=#D5E4E9;strokeColor=#A8C6D0;" parent="1" vertex="1">
          <mxGeometry as="geometry" x="40" y="560" width="1810" height="210"/>
        </mxCell>
        <mxCell id="lane4" value="COHERE HEALTH / OTHER VENDOR — AI &amp; BUSINESS WORKFLOW" style="swimlane;html=1;horizontal=0;startSize=42;fillColor=#7C3AED;swimlaneFillColor=#F8FBFC;fontColor=#FFFFFF;fontStyle=1;fontSize=13;rounded=0;collapsible=0;separatorColor=#D5E4E9;strokeColor=#A8C6D0;" parent="1" vertex="1">
          <mxGeometry as="geometry" x="40" y="790" width="1810" height="210"/>
        </mxCell>
        <mxCell id="n1" value="&lt;b&gt;1. Business change committed&lt;/b&gt;&lt;br&gt;Authorization, member, clinical, claim, or document metadata" style="rounded=1;whiteSpace=wrap;html=1;fillColor=#FFFFFF;strokeColor=#0798B5;strokeWidth=2;fontColor=#102A43;fontSize=12;align=center;verticalAlign=middle;spacing=8;" parent="lane1" vertex="1">
          <mxGeometry as="geometry" x="80" y="55" width="245" height="100"/>
        </mxCell>
        <mxCell id="n2" value="&lt;b&gt;2. Capture committed delta&lt;/b&gt;&lt;br&gt;Transactional outbox or approved CDC" style="rounded=1;whiteSpace=wrap;html=1;fillColor=#FFFFFF;strokeColor=#16A34A;strokeWidth=2;fontColor=#102A43;fontSize=12;align=center;verticalAlign=middle;spacing=8;" parent="lane1" vertex="1">
          <mxGeometry as="geometry" x="385" y="55" width="230" height="100"/>
        </mxCell>
        <mxCell id="n3" value="&lt;b&gt;3. Build governed event&lt;/b&gt;&lt;br&gt;Validate, minimize PHI, add key, event ID, source version and schema" style="rounded=1;whiteSpace=wrap;html=1;fillColor=#FFFFFF;strokeColor=#2563EB;strokeWidth=2;fontColor=#102A43;fontSize=12;align=center;verticalAlign=middle;spacing=8;" parent="lane1" vertex="1">
          <mxGeometry as="geometry" x="680" y="45" width="285" height="120"/>
        </mxCell>
        <mxCell id="n16" value="&lt;b&gt;16. Apply status / result&lt;/b&gt;&lt;br&gt;Update enterprise workflow and source-of-truth state" style="rounded=1;whiteSpace=wrap;html=1;fillColor=#FFFFFF;strokeColor=#7C3AED;strokeWidth=2;fontColor=#102A43;fontSize=12;align=center;verticalAlign=middle;spacing=8;" parent="lane1" vertex="1">
          <mxGeometry as="geometry" x="1475" y="55" width="255" height="100"/>
        </mxCell>
        <mxCell id="n4" value="&lt;b&gt;4. Publish delta&lt;/b&gt;&lt;br&gt;Canonical domain topic or vendor projection topic" style="rounded=1;whiteSpace=wrap;html=1;fillColor=#FFFFFF;strokeColor=#0798B5;strokeWidth=2;fontColor=#102A43;fontSize=12;align=center;verticalAlign=middle;spacing=8;" parent="lane2" vertex="1">
          <mxGeometry as="geometry" x="80" y="55" width="245" height="100"/>
        </mxCell>
        <mxCell id="n5" value="&lt;b&gt;5. Persist and govern&lt;/b&gt;&lt;br&gt;Partitions, retention, schema contract, encryption, quota" style="rounded=1;whiteSpace=wrap;html=1;fillColor=#FFFFFF;strokeColor=#1E293B;strokeWidth=2;fontColor=#102A43;fontSize=12;align=center;verticalAlign=middle;spacing=8;" parent="lane2" vertex="1">
          <mxGeometry as="geometry" x="385" y="45" width="250" height="120"/>
        </mxCell>
        <mxCell id="n6" value="&lt;b&gt;6. Vendor Kafka capable?&lt;/b&gt;&lt;br&gt;Confirm client, network, authentication, checkpoint and support model" style="rhombus;whiteSpace=wrap;html=1;fillColor=#FFF7E8;strokeColor=#CA8A04;strokeWidth=2;fontColor=#102A43;fontSize=11;align=center;verticalAlign=middle;" parent="lane2" vertex="1">
          <mxGeometry as="geometry" x="705" y="38" width="210" height="135"/>
        </mxCell>
        <mxCell id="n7b" value="&lt;b&gt;7B. Enterprise-managed relay&lt;/b&gt;&lt;br&gt;Consume from MSK, filter/translate, call vendor-supported private API" style="rounded=1;whiteSpace=wrap;html=1;fillColor=#FFFFFF;strokeColor=#EA580C;strokeWidth=2;fontColor=#102A43;fontSize=12;align=center;verticalAlign=middle;spacing=8;" parent="lane2" vertex="1">
          <mxGeometry as="geometry" x="990" y="45" width="280" height="120"/>
        </mxCell>
        <mxCell id="n15" value="&lt;b&gt;15. Status / result topic&lt;/b&gt;&lt;br&gt;Acknowledgment, processing state, RFI, decision, or derived event" style="rounded=1;whiteSpace=wrap;html=1;fillColor=#FFFFFF;strokeColor=#7C3AED;strokeWidth=2;fontColor=#102A43;fontSize=12;align=center;verticalAlign=middle;spacing=8;" parent="lane2" vertex="1">
          <mxGeometry as="geometry" x="1475" y="45" width="255" height="120"/>
        </mxCell>
        <mxCell id="n7a" value="&lt;b&gt;7A. Establish private access&lt;/b&gt;&lt;br&gt;PrivateLink / approved path; IAM, SCRAM, or mTLS; topic + group authorization" style="rounded=1;whiteSpace=wrap;html=1;fillColor=#FFFFFF;strokeColor=#2563EB;strokeWidth=2;fontColor=#102A43;fontSize=12;align=center;verticalAlign=middle;spacing=8;" parent="lane3" vertex="1">
          <mxGeometry as="geometry" x="705" y="42" width="265" height="125"/>
        </mxCell>
        <mxCell id="n8" value="&lt;b&gt;8. Vendor consumer polls&lt;/b&gt;&lt;br&gt;Dedicated group per vendor + use case + environment" style="rounded=1;whiteSpace=wrap;html=1;fillColor=#FFFFFF;strokeColor=#2563EB;strokeWidth=2;fontColor=#102A43;fontSize=12;align=center;verticalAlign=middle;spacing=8;" parent="lane3" vertex="1">
          <mxGeometry as="geometry" x="1020" y="45" width="245" height="115"/>
        </mxCell>
        <mxCell id="n9" value="&lt;b&gt;9. Validate and deduplicate&lt;/b&gt;&lt;br&gt;Schema, event ID, source version, authorization context" style="rounded=1;whiteSpace=wrap;html=1;fillColor=#FFFFFF;strokeColor=#0798B5;strokeWidth=2;fontColor=#102A43;fontSize=12;align=center;verticalAlign=middle;spacing=8;" parent="lane3" vertex="1">
          <mxGeometry as="geometry" x="1320" y="45" width="245" height="115"/>
        </mxCell>
        <mxCell id="n13" value="&lt;b&gt;13. Commit offset&lt;/b&gt;&lt;br&gt;Only after durable vendor checkpoint / accepted processing state" style="rounded=1;whiteSpace=wrap;html=1;fillColor=#FFFFFF;strokeColor=#16A34A;strokeWidth=2;fontColor=#102A43;fontSize=12;align=center;verticalAlign=middle;spacing=8;" parent="lane3" vertex="1">
          <mxGeometry as="geometry" x="1580" y="45" width="190" height="115"/>
        </mxCell>
        <mxCell id="n10" value="&lt;b&gt;10. Route delta&lt;/b&gt;&lt;br&gt;Place work into Cohere AI workflow or another vendor application" style="rounded=1;whiteSpace=wrap;html=1;fillColor=#FFFFFF;strokeColor=#7C3AED;strokeWidth=2;fontColor=#102A43;fontSize=12;align=center;verticalAlign=middle;spacing=8;" parent="lane4" vertex="1">
          <mxGeometry as="geometry" x="1020" y="45" width="245" height="115"/>
        </mxCell>
        <mxCell id="n11" value="&lt;b&gt;11. AI / agentic processing&lt;/b&gt;&lt;br&gt;Apply vendor workflow under the contracted purpose" style="rounded=1;whiteSpace=wrap;html=1;fillColor=#FFFFFF;strokeColor=#7C3AED;strokeWidth=2;fontColor=#102A43;fontSize=12;align=center;verticalAlign=middle;spacing=8;" parent="lane4" vertex="1">
          <mxGeometry as="geometry" x="1320" y="45" width="245" height="115"/>
        </mxCell>
        <mxCell id="n12" value="&lt;b&gt;12. Durable checkpoint&lt;/b&gt;&lt;br&gt;Record accepted event ID, workflow state, outcome and trace ID" style="rounded=1;whiteSpace=wrap;html=1;fillColor=#FFFFFF;strokeColor=#16A34A;strokeWidth=2;fontColor=#102A43;fontSize=12;align=center;verticalAlign=middle;spacing=8;" parent="lane4" vertex="1">
          <mxGeometry as="geometry" x="1580" y="45" width="190" height="115"/>
        </mxCell>
        <mxCell id="n14" value="&lt;b&gt;14. Publish acknowledgment / result&lt;/b&gt;&lt;br&gt;Optional return event to enterprise status topic" style="rounded=1;whiteSpace=wrap;html=1;fillColor=#FFFFFF;strokeColor=#7C3AED;strokeWidth=2;fontColor=#102A43;fontSize=12;align=center;verticalAlign=middle;spacing=8;" parent="lane4" vertex="1">
          <mxGeometry as="geometry" x="705" y="45" width="265" height="115"/>
        </mxCell>
        <mxCell id="e1" value="" style="edgeStyle=orthogonalEdgeStyle;rounded=0;orthogonalLoop=1;jettySize=auto;html=1;strokeColor=#0798B5;strokeWidth=2;endArrow=block;endFill=1;" parent="1" edge="1" source="n1" target="n2">
          <mxGeometry as="geometry" relative="1"/>
        </mxCell>
        <mxCell id="e2" value="" style="edgeStyle=orthogonalEdgeStyle;rounded=0;orthogonalLoop=1;jettySize=auto;html=1;strokeColor=#0798B5;strokeWidth=2;endArrow=block;endFill=1;" parent="1" edge="1" source="n2" target="n3">
          <mxGeometry as="geometry" relative="1"/>
        </mxCell>
        <mxCell id="e3" value="" style="edgeStyle=orthogonalEdgeStyle;rounded=0;orthogonalLoop=1;jettySize=auto;html=1;strokeColor=#0798B5;strokeWidth=2;endArrow=block;endFill=1;" parent="1" edge="1" source="n3" target="n4">
          <mxGeometry as="geometry" relative="1"/>
        </mxCell>
        <mxCell id="e4" value="" style="edgeStyle=orthogonalEdgeStyle;rounded=0;orthogonalLoop=1;jettySize=auto;html=1;strokeColor=#0798B5;strokeWidth=2;endArrow=block;endFill=1;" parent="1" edge="1" source="n4" target="n5">
          <mxGeometry as="geometry" relative="1"/>
        </mxCell>
        <mxCell id="e5" value="" style="edgeStyle=orthogonalEdgeStyle;rounded=0;orthogonalLoop=1;jettySize=auto;html=1;strokeColor=#0798B5;strokeWidth=2;endArrow=block;endFill=1;" parent="1" edge="1" source="n5" target="n6">
          <mxGeometry as="geometry" relative="1"/>
        </mxCell>
        <mxCell id="e6" value="YES — direct Kafka" style="edgeStyle=orthogonalEdgeStyle;rounded=0;html=1;strokeColor=#16A34A;strokeWidth=2;endArrow=block;endFill=1;fontSize=11;fontColor=#166534;" parent="1" edge="1" source="n6" target="n7a">
          <mxGeometry as="geometry" relative="1"/>
        </mxCell>
        <mxCell id="e7" value="NO — relay" style="edgeStyle=orthogonalEdgeStyle;rounded=0;html=1;strokeColor=#EA580C;strokeWidth=2;endArrow=block;endFill=1;fontSize=11;fontColor=#9A3412;" parent="1" edge="1" source="n6" target="n7b">
          <mxGeometry as="geometry" relative="1"/>
        </mxCell>
        <mxCell id="e8" value="" style="edgeStyle=orthogonalEdgeStyle;rounded=0;orthogonalLoop=1;jettySize=auto;html=1;strokeColor=#0798B5;strokeWidth=2;endArrow=block;endFill=1;" parent="1" edge="1" source="n7a" target="n8">
          <mxGeometry as="geometry" relative="1"/>
        </mxCell>
        <mxCell id="e9" value="Private/API delivery" style="edgeStyle=orthogonalEdgeStyle;rounded=0;html=1;strokeColor=#EA580C;strokeWidth=2;endArrow=block;endFill=1;fontSize=11;fontColor=#9A3412;" parent="1" edge="1" source="n7b" target="n10">
          <mxGeometry as="geometry" relative="1"/>
        </mxCell>
        <mxCell id="e10" value="" style="edgeStyle=orthogonalEdgeStyle;rounded=0;orthogonalLoop=1;jettySize=auto;html=1;strokeColor=#0798B5;strokeWidth=2;endArrow=block;endFill=1;" parent="1" edge="1" source="n8" target="n9">
          <mxGeometry as="geometry" relative="1"/>
        </mxCell>
        <mxCell id="e11" value="" style="edgeStyle=orthogonalEdgeStyle;rounded=0;orthogonalLoop=1;jettySize=auto;html=1;strokeColor=#0798B5;strokeWidth=2;endArrow=block;endFill=1;" parent="1" edge="1" source="n9" target="n10">
          <mxGeometry as="geometry" relative="1"/>
        </mxCell>
        <mxCell id="e12" value="" style="edgeStyle=orthogonalEdgeStyle;rounded=0;orthogonalLoop=1;jettySize=auto;html=1;strokeColor=#0798B5;strokeWidth=2;endArrow=block;endFill=1;" parent="1" edge="1" source="n10" target="n11">
          <mxGeometry as="geometry" relative="1"/>
        </mxCell>
        <mxCell id="e13" value="" style="edgeStyle=orthogonalEdgeStyle;rounded=0;orthogonalLoop=1;jettySize=auto;html=1;strokeColor=#0798B5;strokeWidth=2;endArrow=block;endFill=1;" parent="1" edge="1" source="n11" target="n12">
          <mxGeometry as="geometry" relative="1"/>
        </mxCell>
        <mxCell id="e14" value="" style="edgeStyle=orthogonalEdgeStyle;rounded=0;html=1;strokeColor=#16A34A;strokeWidth=2;endArrow=block;endFill=1;fontSize=11;fontColor=#166534;" parent="1" edge="1" source="n12" target="n13">
          <mxGeometry as="geometry" relative="1"/>
        </mxCell>
        <mxCell id="e15" value="Optional outcome" style="edgeStyle=orthogonalEdgeStyle;rounded=0;html=1;strokeColor=#7C3AED;strokeWidth=2;dashed=1;endArrow=block;endFill=1;fontSize=11;fontColor=#6D28D9;" parent="1" edge="1" source="n12" target="n14">
          <mxGeometry as="geometry" relative="1"/>
        </mxCell>
        <mxCell id="e16" value="" style="edgeStyle=orthogonalEdgeStyle;rounded=0;html=1;strokeColor=#7C3AED;strokeWidth=2;dashed=1;endArrow=block;endFill=1;fontSize=11;fontColor=#6D28D9;" parent="1" edge="1" source="n14" target="n15">
          <mxGeometry as="geometry" relative="1"/>
        </mxCell>
        <mxCell id="e17" value="" style="edgeStyle=orthogonalEdgeStyle;rounded=0;html=1;strokeColor=#7C3AED;strokeWidth=2;dashed=1;endArrow=block;endFill=1;fontSize=11;fontColor=#6D28D9;" parent="1" edge="1" source="n15" target="n16">
          <mxGeometry as="geometry" relative="1"/>
        </mxCell>
        <mxCell id="lg1" value="&lt;b&gt;Independent delta position:&lt;/b&gt; each vendor/use case/environment has a unique consumer group and committed offsets." style="rounded=1;whiteSpace=wrap;html=1;fillColor=#E4F6F8;strokeColor=#9BD9E2;fontColor=#24515A;fontSize=12;align=left;spacingLeft=12;" parent="1" vertex="1">
          <mxGeometry as="geometry" x="45" y="1020" width="855" height="62"/>
        </mxCell>
        <mxCell id="lg2" value="&lt;b&gt;Failure controls:&lt;/b&gt; bounded retry → quarantine/DLQ → operator-approved replay; alert on business-time lag and retention risk." style="rounded=1;whiteSpace=wrap;html=1;fillColor=#FFF1E7;strokeColor=#F3BE91;fontColor=#9A3412;fontSize=12;align=left;spacingLeft=12;" parent="1" vertex="1">
          <mxGeometry as="geometry" x="925" y="1020" width="920" height="62"/>
        </mxCell>
        <mxCell id="lg3" value="Direct access is conditional. Preserve the managed-relay option until vendor Kafka capability and contractual responsibilities are validated." style="text;html=1;align=center;fontSize=11;fontStyle=2;fontColor=#536B7D;" parent="1" vertex="1">
          <mxGeometry as="geometry" x="290" y="1090" width="1300" height="35"/>
        </mxCell>
      </root>
    </mxGraphModel>
  </diagram>
  <diagram id="onboarding-flow" name="2 - Vendor Onboarding and Operations">
    <mxGraphModel dx="1900" dy="1180" grid="1" gridSize="10" guides="1" tooltips="1" connect="1" arrows="1" fold="1" page="1" pageScale="1" pageWidth="1900" pageHeight="1180" math="0" shadow="0">
      <root>
        <mxCell id="0"/>
        <mxCell id="1" parent="0"/>
        <mxCell id="p2t" value="Vendor Subscription — Onboarding, Operations and Offboarding Swimlane" style="text;html=1;align=left;fontSize=27;fontStyle=1;fontColor=#102A43;" parent="1" vertex="1">
          <mxGeometry as="geometry" x="40" y="15" width="1600" height="45"/>
        </mxCell>
        <mxCell id="p2s" value="Reusable MSK product workflow for Cohere Health and other vendors." style="text;html=1;align=left;fontSize=15;fontColor=#536B7D;" parent="1" vertex="1">
          <mxGeometry as="geometry" x="42" y="60" width="1500" height="28"/>
        </mxCell>
        <mxCell id="l21" value="BUSINESS / DATA PRODUCT OWNER" style="swimlane;html=1;horizontal=0;startSize=42;fillColor=#0798B5;swimlaneFillColor=#F8FBFC;fontColor=#FFFFFF;fontStyle=1;fontSize=13;rounded=0;collapsible=0;separatorColor=#D5E4E9;strokeColor=#A8C6D0;" parent="1" vertex="1">
          <mxGeometry as="geometry" x="40" y="100" width="1810" height="210"/>
        </mxCell>
        <mxCell id="l22" value="MSK PLATFORM PRODUCT TEAM" style="swimlane;html=1;horizontal=0;startSize=42;fillColor=#1E293B;swimlaneFillColor=#F8FBFC;fontColor=#FFFFFF;fontStyle=1;fontSize=13;rounded=0;collapsible=0;separatorColor=#D5E4E9;strokeColor=#A8C6D0;" parent="1" vertex="1">
          <mxGeometry as="geometry" x="40" y="330" width="1810" height="210"/>
        </mxCell>
        <mxCell id="l23" value="SECURITY / PRIVACY / ARCHITECTURE" style="swimlane;html=1;horizontal=0;startSize=42;fillColor=#EA580C;swimlaneFillColor=#F8FBFC;fontColor=#FFFFFF;fontStyle=1;fontSize=13;rounded=0;collapsible=0;separatorColor=#D5E4E9;strokeColor=#A8C6D0;" parent="1" vertex="1">
          <mxGeometry as="geometry" x="40" y="560" width="1810" height="210"/>
        </mxCell>
        <mxCell id="l24" value="COHERE HEALTH / OTHER VENDOR" style="swimlane;html=1;horizontal=0;startSize=42;fillColor=#7C3AED;swimlaneFillColor=#F8FBFC;fontColor=#FFFFFF;fontStyle=1;fontSize=13;rounded=0;collapsible=0;separatorColor=#D5E4E9;strokeColor=#A8C6D0;" parent="1" vertex="1">
          <mxGeometry as="geometry" x="40" y="790" width="1810" height="210"/>
        </mxCell>
        <mxCell id="a1" value="&lt;b&gt;1. Submit use case&lt;/b&gt;&lt;br&gt;Purpose, data, source, freshness, outcome, vendor" style="rounded=1;whiteSpace=wrap;html=1;fillColor=#FFFFFF;strokeColor=#0798B5;strokeWidth=2;fontColor=#102A43;fontSize=12;align=center;verticalAlign=middle;spacing=8;" parent="l21" vertex="1">
          <mxGeometry as="geometry" x="70" y="45" width="220" height="115"/>
        </mxCell>
        <mxCell id="a2" value="&lt;b&gt;2. Discover vendor capability&lt;/b&gt;&lt;br&gt;Kafka client, network, auth, schema, volume, checkpoints, support" style="rounded=1;whiteSpace=wrap;html=1;fillColor=#FFFFFF;strokeColor=#7C3AED;strokeWidth=2;fontColor=#102A43;fontSize=12;align=center;verticalAlign=middle;spacing=8;" parent="l24" vertex="1">
          <mxGeometry as="geometry" x="340" y="42" width="255" height="125"/>
        </mxCell>
        <mxCell id="a3" value="&lt;b&gt;3. Classify and choose pattern&lt;/b&gt;&lt;br&gt;Direct consumer, managed relay, or projection cluster" style="rounded=1;whiteSpace=wrap;html=1;fillColor=#FFFFFF;strokeColor=#2563EB;strokeWidth=2;fontColor=#102A43;fontSize=12;align=center;verticalAlign=middle;spacing=8;" parent="l22" vertex="1">
          <mxGeometry as="geometry" x="650" y="42" width="260" height="125"/>
        </mxCell>
        <mxCell id="a4" value="&lt;b&gt;4. Approve trust boundary&lt;/b&gt;&lt;br&gt;PHI purpose, minimum necessary, BAA/contract, identity, retention" style="rounded=1;whiteSpace=wrap;html=1;fillColor=#FFFFFF;strokeColor=#EA580C;strokeWidth=2;fontColor=#102A43;fontSize=12;align=center;verticalAlign=middle;spacing=8;" parent="l23" vertex="1">
          <mxGeometry as="geometry" x="965" y="42" width="260" height="125"/>
        </mxCell>
        <mxCell id="a5" value="&lt;b&gt;5. Provision subscription&lt;/b&gt;&lt;br&gt;Topic/projection, consumer group, quota, network, credential, dashboard" style="rounded=1;whiteSpace=wrap;html=1;fillColor=#FFFFFF;strokeColor=#16A34A;strokeWidth=2;fontColor=#102A43;fontSize=12;align=center;verticalAlign=middle;spacing=8;" parent="l22" vertex="1">
          <mxGeometry as="geometry" x="1280" y="42" width="280" height="125"/>
        </mxCell>
        <mxCell id="a6" value="&lt;b&gt;6. Certify consumer&lt;/b&gt;&lt;br&gt;Contract, load, duplicate, outage, lag, replay and security tests" style="rounded=1;whiteSpace=wrap;html=1;fillColor=#FFFFFF;strokeColor=#7C3AED;strokeWidth=2;fontColor=#102A43;fontSize=12;align=center;verticalAlign=middle;spacing=8;" parent="l24" vertex="1">
          <mxGeometry as="geometry" x="1595" y="42" width="175" height="125"/>
        </mxCell>
        <mxCell id="a7" value="&lt;b&gt;7. Approve production&lt;/b&gt;&lt;br&gt;Owner, SLO, runbook, support, cost and evidence" style="rounded=1;whiteSpace=wrap;html=1;fillColor=#FFFFFF;strokeColor=#0798B5;strokeWidth=2;fontColor=#102A43;fontSize=12;align=center;verticalAlign=middle;spacing=8;" parent="l21" vertex="1">
          <mxGeometry as="geometry" x="1595" y="42" width="175" height="125"/>
        </mxCell>
        <mxCell id="a8" value="&lt;b&gt;8. Operate service&lt;/b&gt;&lt;br&gt;Monitor lag/freshness, reconcile, rotate, attest and manage incidents" style="rounded=1;whiteSpace=wrap;html=1;fillColor=#FFFFFF;strokeColor=#16A34A;strokeWidth=2;fontColor=#102A43;fontSize=12;align=center;verticalAlign=middle;spacing=8;" parent="l22" vertex="1">
          <mxGeometry as="geometry" x="1280" y="42" width="280" height="125"/>
        </mxCell>
        <mxCell id="a9" value="&lt;b&gt;9. Operate vendor consumer&lt;/b&gt;&lt;br&gt;Process, checkpoint, report status, support failures and backlog" style="rounded=1;whiteSpace=wrap;html=1;fillColor=#FFFFFF;strokeColor=#7C3AED;strokeWidth=2;fontColor=#102A43;fontSize=12;align=center;verticalAlign=middle;spacing=8;" parent="l24" vertex="1">
          <mxGeometry as="geometry" x="965" y="42" width="260" height="125"/>
        </mxCell>
        <mxCell id="a10" value="&lt;b&gt;10. Review data use&lt;/b&gt;&lt;br&gt;Access attestation, purpose, retention, model-use and subprocessor review" style="rounded=1;whiteSpace=wrap;html=1;fillColor=#FFFFFF;strokeColor=#EA580C;strokeWidth=2;fontColor=#102A43;fontSize=12;align=center;verticalAlign=middle;spacing=8;" parent="l23" vertex="1">
          <mxGeometry as="geometry" x="650" y="42" width="260" height="125"/>
        </mxCell>
        <mxCell id="a11" value="&lt;b&gt;11. Offboard / change&lt;/b&gt;&lt;br&gt;Stop flow, revoke, disconnect, archive/delete, preserve evidence" style="rounded=1;whiteSpace=wrap;html=1;fillColor=#FFFFFF;strokeColor=#B42318;strokeWidth=2;fontColor=#102A43;fontSize=12;align=center;verticalAlign=middle;spacing=8;" parent="l22" vertex="1">
          <mxGeometry as="geometry" x="340" y="42" width="255" height="125"/>
        </mxCell>
        <mxCell id="a12" value="&lt;b&gt;12. Close business use&lt;/b&gt;&lt;br&gt;Confirm disposition and terminate funding / ownership" style="rounded=1;whiteSpace=wrap;html=1;fillColor=#FFFFFF;strokeColor=#B42318;strokeWidth=2;fontColor=#102A43;fontSize=12;align=center;verticalAlign=middle;spacing=8;" parent="l21" vertex="1">
          <mxGeometry as="geometry" x="70" y="45" width="220" height="115"/>
        </mxCell>
        <mxCell id="ae1" value="" style="edgeStyle=orthogonalEdgeStyle;rounded=0;orthogonalLoop=1;jettySize=auto;html=1;strokeColor=#0798B5;strokeWidth=2;endArrow=block;endFill=1;" parent="1" edge="1" source="a1" target="a2">
          <mxGeometry as="geometry" relative="1"/>
        </mxCell>
        <mxCell id="ae2" value="" style="edgeStyle=orthogonalEdgeStyle;rounded=0;orthogonalLoop=1;jettySize=auto;html=1;strokeColor=#0798B5;strokeWidth=2;endArrow=block;endFill=1;" parent="1" edge="1" source="a2" target="a3">
          <mxGeometry as="geometry" relative="1"/>
        </mxCell>
        <mxCell id="ae3" value="" style="edgeStyle=orthogonalEdgeStyle;rounded=0;orthogonalLoop=1;jettySize=auto;html=1;strokeColor=#0798B5;strokeWidth=2;endArrow=block;endFill=1;" parent="1" edge="1" source="a3" target="a4">
          <mxGeometry as="geometry" relative="1"/>
        </mxCell>
        <mxCell id="ae4" value="" style="edgeStyle=orthogonalEdgeStyle;rounded=0;orthogonalLoop=1;jettySize=auto;html=1;strokeColor=#0798B5;strokeWidth=2;endArrow=block;endFill=1;" parent="1" edge="1" source="a4" target="a5">
          <mxGeometry as="geometry" relative="1"/>
        </mxCell>
        <mxCell id="ae5" value="" style="edgeStyle=orthogonalEdgeStyle;rounded=0;orthogonalLoop=1;jettySize=auto;html=1;strokeColor=#0798B5;strokeWidth=2;endArrow=block;endFill=1;" parent="1" edge="1" source="a5" target="a6">
          <mxGeometry as="geometry" relative="1"/>
        </mxCell>
        <mxCell id="ae6" value="" style="edgeStyle=orthogonalEdgeStyle;rounded=0;orthogonalLoop=1;jettySize=auto;html=1;strokeColor=#0798B5;strokeWidth=2;endArrow=block;endFill=1;" parent="1" edge="1" source="a6" target="a7">
          <mxGeometry as="geometry" relative="1"/>
        </mxCell>
        <mxCell id="ae7" value="" style="edgeStyle=orthogonalEdgeStyle;rounded=0;html=1;strokeColor=#7C3AED;strokeWidth=2;endArrow=block;endFill=1;" parent="1" edge="1" source="a7" target="a8">
          <mxGeometry as="geometry" relative="1"/>
        </mxCell>
        <mxCell id="ae8" value="" style="edgeStyle=orthogonalEdgeStyle;rounded=0;html=1;strokeColor=#7C3AED;strokeWidth=2;endArrow=block;endFill=1;" parent="1" edge="1" source="a8" target="a9">
          <mxGeometry as="geometry" relative="1"/>
        </mxCell>
        <mxCell id="ae9" value="" style="edgeStyle=orthogonalEdgeStyle;rounded=0;html=1;strokeColor=#7C3AED;strokeWidth=2;endArrow=block;endFill=1;" parent="1" edge="1" source="a9" target="a10">
          <mxGeometry as="geometry" relative="1"/>
        </mxCell>
        <mxCell id="ae10" value="" style="edgeStyle=orthogonalEdgeStyle;rounded=0;html=1;strokeColor=#7C3AED;strokeWidth=2;endArrow=block;endFill=1;" parent="1" edge="1" source="a10" target="a11">
          <mxGeometry as="geometry" relative="1"/>
        </mxCell>
        <mxCell id="ae11" value="" style="edgeStyle=orthogonalEdgeStyle;rounded=0;html=1;strokeColor=#7C3AED;strokeWidth=2;endArrow=block;endFill=1;" parent="1" edge="1" source="a11" target="a12">
          <mxGeometry as="geometry" relative="1"/>
        </mxCell>
        <mxCell id="gate" value="&lt;b&gt;Production gate&lt;/b&gt;&lt;br&gt;Contract/privacy approval + certified behavior + named support + recovery evidence + measured SLO" style="rounded=1;whiteSpace=wrap;html=1;fillColor=#E8F7ED;strokeColor=#16A34A;strokeWidth=2;fontColor=#166534;fontSize=12;align=center;" parent="1" vertex="1">
          <mxGeometry as="geometry" x="690" y="1020" width="500" height="62"/>
        </mxCell>
        <mxCell id="ops" value="&lt;b&gt;Continuous controls:&lt;/b&gt; topic/group authorization • consumer lag • freshness • reconciliation • replay evidence • cost • credential rotation" style="rounded=1;whiteSpace=wrap;html=1;fillColor=#E4F6F8;strokeColor=#9BD9E2;fontColor=#24515A;fontSize=12;align=center;" parent="1" vertex="1">
          <mxGeometry as="geometry" x="240" y="1090" width="1400" height="50"/>
        </mxCell>
      </root>
    </mxGraphModel>
  </diagram>
</mxfile>
