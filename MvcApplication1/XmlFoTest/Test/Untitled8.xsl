  <?xml version="1.0" encoding="utf-8" ?> 
- <fo:root xmlns:fo="http://www.w3.org/1999/XSL/Format">
- <fo:layout-master-set>
- <!-- Master details for information section
  --> 
- <!-- 
		<fo:simple-page-master master-name="first-page" page-width="1010px" margin-top="60px" margin-bottom="80px" 
			margin-left="60px"  margin-right="60px">
			<fo:region-body/>
			<fo:region-after extent="5px"/>
		</fo:simple-page-master>
		

  --> 
- <!-- Master details for Project Details section
  --> 
- <fo:simple-page-master master-name="project-details" page-width="1010px" margin-top="60px" margin-bottom="80px" margin-left="60px" margin-right="60px">
- <!-- body
  --> 
  <fo:region-body column-count="2" reference-orientation="0" column-gap="30px" /> 
- <!-- footer
  --> 
  <fo:region-after extent="5px" /> 
  </fo:simple-page-master>
- <fo:page-sequence-master master-name="PagingAll">
  <fo:repeatable-page-master-reference master-reference="project-details" /> 
  </fo:page-sequence-master>
  </fo:layout-master-set>
- <!-- footer
  --> 
- <!-- PageCover
  --> 
- <fo:page-sequence master-reference="PagingAll" format="1">
- <fo:static-content flow-name="xsl-region-after">
  <fo:block margin-left="8px" margin-right="8px" font="5pt ARIAL" color="#666666">The Onvia Guide © 2008 Onvia, Inc. All rights are reserved. Unless you have a multiple site or multiple office license with Onvia, only you alone can use The Onvia Guide at asingle location. Without the written consent of Onvia, you cannot modify, copy, display, reproduce, share, sell, publish, transfer, assign, or distribute The Onvia Guide or anyportion thereof. For any questions regarding licenses to your other office locations, please contact Onvia Customer Service at (888)484-3374 or customerservice@onvia.com</fo:block> 
- <fo:block text-align="right">
- <fo:inline text-align="right" color="#000000" font="5pt ARIAL">
  <fo:page-number /> 
  </fo:inline>
  </fo:block>
  </fo:static-content>
- <fo:flow flow-name="xsl-region-body" span="all">
- <!-- Header Image
  --> 
- <fo:block>
  <fo:external-graphic content-width="890px" src="url('Images\GuideCoverTopBar.gif')" /> 
  </fo:block>
- <fo:block margin-left="350px" span="all">
  <fo:block margin-top="35px" font="10pt ARIAL" height="=58px" vertical-align="top">Volume 14, Number 169</fo:block> 
  <fo:block margin-top="10px" linefeed-treatment="preserve" font="22pt ARIAL" height="41px" vertical-align="top">Daily Guide</fo:block> 
  <fo:block margin-top="7px" linefeed-treatment="preserve" font="22pt ARIAL" height="41px" vertical-align="top">August 28, 2008</fo:block> 
  <fo:block margin-top="15px" border="1px solid #ccc" /> 
  <fo:block margin-top="15px" linefeed-treatment="preserve" font="16pt ARIAL" height="42px">Michael Johnson</fo:block> 
  <fo:block margin-top="10px" linefeed-treatment="preserve" font="16pt ARIAL" height="42px">Johnson Construction, LLC</fo:block> 
  <fo:block margin-top="10px" linefeed-treatment="preserve" font="16pt ARIAL" height="42px">Eugene, OR</fo:block> 
  <fo:block margin-top="18px" border="1px solid #ccc" /> 
  </fo:block>
  </fo:flow>
  </fo:page-sequence>
- <!-- Table of Contents
  --> 
- <fo:page-sequence master-reference="PagingAll" format="1">
- <!-- footer
  --> 
- <fo:static-content flow-name="xsl-region-after">
  <fo:block margin-left="8px" margin-right="8px" font="5pt ARIAL" color="#666666">The Onvia Guide © 2008 Onvia, Inc. All rights are reserved. Unless you have a multiple site or multiple office license with Onvia, only you alone can use The Onvia Guide at asingle location. Without the written consent of Onvia, you cannot modify, copy, display, reproduce, share, sell, publish, transfer, assign, or distribute The Onvia Guide or anyportion thereof. For any questions regarding licenses to your other office locations, please contact Onvia Customer Service at (888)484-3374 or customerservice@onvia.com</fo:block> 
- <fo:block text-align="right">
- <fo:inline text-align="right" color="#000000" font="5pt ARIAL">
  <fo:page-number /> 
  </fo:inline>
  </fo:block>
  </fo:static-content>
- <!-- body
  --> 
- <fo:flow flow-name="xsl-region-body">
- <fo:block-container width="890px" background-image="url('Images\GuideHeaderLarge.gif')" height="148px" display-align="after">
- <fo:block margin-left="450px" margin-bottom="28px" font="14pt ARIAL" color="#FFFFFF">
  Daily Guide, August 28, 2008 
  <fo:inline font="7pt ARIAL" color="#000000">Volume 16, Issue 169</fo:inline> 
  </fo:block>
  </fo:block-container>
- <fo:block margin-top="8px" margin-left="5px" span="all">
- <fo:table>
- <fo:table-body>
- <fo:table-row>
- <fo:table-cell width="350px">
  <fo:block font="14pt ARIAL">Michael Johnson</fo:block> 
  <fo:block font="9pt ARIAL">Johnson Construction, LLC</fo:block> 
  <fo:block font="9pt ARIAL">Eugene, Oregon</fo:block> 
- <fo:block font="7pt" color="#0033CC">
  <fo:basic-link external-destination="url('http://www.google.com/')" text-decoration="underline">[ Manage Profile ]</fo:basic-link> 
  </fo:block>
  </fo:table-cell>
- <fo:table-cell width="220px">
- <fo:table font="7pt ARIAL" color="#666">
  <fo:table-column column-width="130px" /> 
  <fo:table-column column-width="160px" /> 
- <fo:table-body>
- <fo:table-row>
- <fo:table-cell>
  <fo:block color="#666">Subscription:</fo:block> 
  </fo:table-cell>
- <fo:table-cell>
- <fo:block>
  End 11/15/08, 
  <fo:basic-link external-destination="url('http://www.RenderX.com/')" text-decoration="underline" color="blue">Renew Now</fo:basic-link> 
  </fo:block>
  </fo:table-cell>
  </fo:table-row>
- <fo:table-row>
- <fo:table-cell>
  <fo:block color="#666">locations:</fo:block> 
  </fo:table-cell>
- <fo:table-cell>
  <fo:block color="#000">OR, WA</fo:block> 
  </fo:table-cell>
  </fo:table-row>
- <fo:table-row>
- <fo:table-cell>
  <fo:block color="#666">Onvia Account:</fo:block> 
  </fo:table-cell>
- <fo:table-cell>
  <fo:block color="#000">7182733</fo:block> 
  </fo:table-cell>
  </fo:table-row>
- <fo:table-row>
- <fo:table-cell>
  <fo:block color="#666">Executive:</fo:block> 
  </fo:table-cell>
- <fo:table-cell>
  <fo:block color="#000">Ronald McDonald</fo:block> 
  </fo:table-cell>
  </fo:table-row>
- <fo:table-row>
- <fo:table-cell>
  <fo:block color="#666">Phone:</fo:block> 
  </fo:table-cell>
- <fo:table-cell>
  <fo:block color="#000">(888) 393-4567</fo:block> 
  </fo:table-cell>
  </fo:table-row>
  </fo:table-body>
  </fo:table>
  </fo:table-cell>
- <fo:table-cell>
- <fo:block>
  <fo:external-graphic src="url('Images\GoToOnlineGuide.gif')" content-width="220px" /> 
  </fo:block>
  </fo:table-cell>
  </fo:table-row>
  </fo:table-body>
  </fo:table>
  </fo:block>
- <fo:block margin-top="10px" span="all">
  <fo:external-graphic src="url('Images\GreyHorizontalBar.gif')" content-width="890px" /> 
  </fo:block>
- <fo:block margin-top="20px" span="all">
- <fo:table>
  <fo:table-column column-width="300px" /> 
  <fo:table-column column-width="500px" /> 
- <fo:table-body>
- <fo:table-row>
- <fo:table-cell>
  <fo:block font="14pt ARIAL">Product News</fo:block> 
  <fo:block margin-top="15px" margin-right="50px" border="1px solid #ccc" /> 
- <fo:block margin-right="50px" padding-top="6px" font="9pt ARIAL" linefeed-treatment="preserve">
  <fo:inline font="11pt ARIAL">Oregon State Launches 15 New Projects in November</fo:inline> 
  Across the education and healthcare markets and requiring A and E and construction assistance, The State of Oregon announced 15 new initiatives totalling over 18 milion dollars. 
  </fo:block>
  <fo:block margin-top="15px" margin-right="50px" border="1px solid #ccc" /> 
- <fo:block margin-right="50px" padding-top="9px" font="9pt ARIAL" linefeed-treatment="preserve">
  <fo:inline font="11pt ARIAL">Getting Wired</fo:inline> 
  <fo:block margin-right="50px" font="9pt ARIAL">Onvia was featured in Wired Magazine in October. Read what 5 customers said about "Finding what you are looking for." Vice President of Product Michael Balsam is quoted " Our Success is really all about how smart we can be with data... content"</fo:block> 
  </fo:block>
  <fo:block margin-top="15px" margin-right="50px" border="1px solid #ccc" /> 
- <fo:block margin-right="50px" padding-top="9px" font="9pt ARIAL" linefeed-treatment="preserve">
  <fo:inline font="11pt ARIAL" linefeed-treatment="preserve">6 Million and Growing</fo:inline> 
  <fo:block margin-right="50px" font="9pt ARIAL">we have over 6 million records now and growing fast. With the demand for more accurate and timely public and private sector data, Onvia is increasing the number of sources and resources we apply to the task. Notable additions to our already robust dataset include.</fo:block> 
  </fo:block>
  <fo:block margin-top="15px" margin-right="50px" border="1px solid #ccc" /> 
  </fo:table-cell>
- <fo:table-cell>
  <fo:block font="14pt ARIAL">Contents</fo:block> 
- <fo:table margin-top="10px">
  <fo:table-column column-width="340px" /> 
- <fo:table-body>
- <fo:table-row>
- <fo:table-cell>
  <fo:block font="7pt" color="#666666">Item</fo:block> 
  </fo:table-cell>
- <fo:table-cell>
  <fo:block font="7pt" color="#666666">Page</fo:block> 
  </fo:table-cell>
  </fo:table-row>
  </fo:table-body>
  </fo:table>
  <fo:block margin-right="50px" border="1px solid #ccc" /> 
  <fo:block padding-top="9px" font="10pt ARIAL">Your Saved Searches</fo:block> 
- <fo:block font="7pt ARIAL" color="#0033CC" padding-top="3px">
  [ 
  <fo:basic-link text-decoration="underline" external-destination="url('http://www.google.com/')">Manage Saved Searches</fo:basic-link> 
  ] 
  </fo:block>
- <fo:table>
- <fo:table-body>
- <fo:table-row>
- <fo:table-cell>
- <fo:table margin-top="10px">
  <fo:table-column column-width="50px" /> 
  <fo:table-column column-width="150px" /> 
  <fo:table-column column-width="150px" /> 
- <fo:table-body>
- <fo:table-row>
- <fo:table-cell>
  <fo:block>1 -</fo:block> 
  </fo:table-cell>
- <fo:table-cell font="9pt ARIAL" padding-bottom="5px">
- <fo:block>
  <fo:basic-link external-destination="url('http://www.RenderX.com/')" text-decoration="underline" color="blue">A and E Oregon</fo:basic-link> 
  </fo:block>
- <fo:block>
  <fo:basic-link external-destination="url('http://www.RenderX.com/')" text-decoration="underline" color="blue">RFP/RFQ/RFI - (1)</fo:basic-link> 
  </fo:block>
- <fo:block>
  <fo:basic-link internal-destination="PrePlanning" text-decoration="underline" color="blue">Pre Planning - (1)</fo:basic-link> 
  </fo:block>
- <fo:block>
  <fo:basic-link internal-destination="Amendment" text-decoration="underline" color="blue">Amendment - (3)</fo:basic-link> 
  </fo:block>
  </fo:table-cell>
- <fo:table-cell>
  <fo:block /> 
  </fo:table-cell>
- <fo:table-cell font="9pt ARIAL">
- <fo:block>
  <fo:basic-link internal-destination="PrePlanning" text-decoration="underline" color="blue">4-9</fo:basic-link> 
  </fo:block>
  </fo:table-cell>
  </fo:table-row>
- <fo:table-row>
- <fo:table-cell>
  <fo:block>2 -</fo:block> 
  </fo:table-cell>
- <fo:table-cell font="9pt ARIAL" padding-bottom="5px">
- <fo:block>
  <fo:basic-link external-destination="url('http://www.RenderX.com/')" text-decoration="underline" color="blue">A and E Oregon</fo:basic-link> 
  </fo:block>
- <fo:block>
  <fo:basic-link external-destination="url('http://www.RenderX.com/')" text-decoration="underline" color="blue">RFP/RFQ/RFI - (1)</fo:basic-link> 
  </fo:block>
- <fo:block>
  <fo:basic-link internal-destination="PrePlanning" text-decoration="underline" color="blue">Pre Planning - (1)</fo:basic-link> 
  </fo:block>
- <fo:block>
  <fo:basic-link internal-destination="Amendment" text-decoration="underline" color="blue">Amendment - (3)</fo:basic-link> 
  </fo:block>
  </fo:table-cell>
- <fo:table-cell>
  <fo:block /> 
  </fo:table-cell>
- <fo:table-cell font="9pt ARIAL">
- <fo:block>
  <fo:basic-link internal-destination="Amendment" text-decoration="underline" color="blue">10-15</fo:basic-link> 
  </fo:block>
  </fo:table-cell>
  </fo:table-row>
  </fo:table-body>
  </fo:table>
- <fo:block span="all">
  <fo:leader leader-length="100%" leader-pattern="rule" alignment-baseline="middle" rule-thickness="2px" color="#CCCCCC" /> 
  </fo:block>
- <fo:table span="all">
  <fo:table-column column-width="350px" /> 
  <fo:table-column column-width="150px" /> 
- <fo:table-body>
- <fo:table-row padding-top="10px" padding-bottom="10px">
- <fo:table-cell>
  <fo:block margin-left="6px">Index of Organizations</fo:block> 
  </fo:table-cell>
- <fo:table-cell font="9pt ARIAL">
- <fo:block>
  <fo:basic-link internal-destination="0" text-decoration="underline" color="blue">16-17</fo:basic-link> 
  </fo:block>
  </fo:table-cell>
  </fo:table-row>
  </fo:table-body>
  </fo:table>
- <fo:block span="all">
  <fo:leader leader-length="100%" leader-pattern="rule" alignment-baseline="middle" rule-thickness="2px" color="#CCCCCC" /> 
  </fo:block>
  </fo:table-cell>
- <fo:table-cell>
  <fo:block /> 
  </fo:table-cell>
  </fo:table-row>
  </fo:table-body>
  </fo:table>
  </fo:table-cell>
  </fo:table-row>
  </fo:table-body>
  </fo:table>
  </fo:block>
  </fo:flow>
  </fo:page-sequence>
- <!-- Project details(Amendment)
  --> 
- <fo:page-sequence master-reference="PagingAll" id="Amendment">
- <fo:static-content flow-name="xsl-region-after">
  <fo:block margin-left="8px" margin-right="8px" font="5pt ARIAL" color="#666666">The Onvia Guide © 2008 Onvia, Inc. All rights are reserved. Unless you have a multiple site or multiple office license with Onvia, only you alone can use The Onvia Guide at asingle location. Without the written consent of Onvia, you cannot modify, copy, display, reproduce, share, sell, publish, transfer, assign, or distribute The Onvia Guide or anyportion thereof. For any questions regarding licenses to your other office locations, please contact Onvia Customer Service at (888)484-3374 or customerservice@onvia.com</fo:block> 
- <fo:block text-align="right">
- <fo:inline text-align="right" color="#000000" font="5pt ARIAL">
  <fo:page-number /> 
  </fo:inline>
  </fo:block>
  </fo:static-content>
- <fo:flow flow-name="xsl-region-body">
- <!-- Header Image
  --> 
- <fo:block-container span="all" width="890px" background-image="url('Images\GuideCoverTopBar.gif')" height="47px" background-repeat="no-repeat" display-align="center">
- <fo:block margin-left="250px">
- <fo:table>
- <fo:table-body>
- <fo:table-row>
+ <fo:table-cell width="500px">
  <fo:block font="14pt ARIAL" color="#FFFFFF">Daily Guide, August 28, 2008</fo:block> 
  </fo:table-cell>
- <fo:table-cell>
  <fo:block font="7pt ARIAL" color="#FFFFFF">Volume 16, Issue 169</fo:block> 
  </fo:table-cell>
  </fo:table-row>
  </fo:table-body>
  </fo:table>
  </fo:block>
  </fo:block-container>
- <!-- Subscriber Details
  --> 
- <fo:block span="all">
- <fo:table>
- <fo:table-body>
- <fo:table-row>
- <fo:table-cell width="660px">
  <fo:block font="9pt ARIAL" color="#000000">Michael Johnson, Johnson Construction, LLC, Eugene, OR</fo:block> 
  </fo:table-cell>
- <fo:table-cell>
- <fo:block>
- <fo:table font="7pt ARIAL #666666">
  <fo:table-column column-width="140px" /> 
  <fo:table-column column-width="120px" /> 
- <fo:table-body>
- <fo:table-row>
- <fo:table-cell>
  <fo:block font="7pt ARIAL" color="#000000">Onvia Account Executive:</fo:block> 
  </fo:table-cell>
- <fo:table-cell>
  <fo:block font="7pt ARIAL" color="#0033CC" text-decoration="underline">Jane Smolyenko</fo:block> 
  </fo:table-cell>
  </fo:table-row>
- <fo:table-row>
- <fo:table-cell>
  <fo:block font="7pt ARIAL" color="#000000">Phone:</fo:block> 
  </fo:table-cell>
- <fo:table-cell>
  <fo:block>(888) 3934567</fo:block> 
  </fo:table-cell>
  </fo:table-row>
  </fo:table-body>
  </fo:table>
  </fo:block>
  </fo:table-cell>
  </fo:table-row>
  </fo:table-body>
  </fo:table>
  </fo:block>
- <!-- Subscriber Footer
  --> 
- <fo:block span="all">
  <fo:external-graphic content-width="890px" src="url('Images\GreyHorizontalBar.gif')" /> 
  </fo:block>
- <!-- Saved Search title
  --> 
  <fo:block span="all" font="7pt ARIAL" margin-left="8px" margin-top="8px" color="#666666">Saved Search 1</fo:block> 
  <fo:block span="all" font="14pt ARIAL" margin-left="8px" margin-top="8px" color="#000000">A & E Oregon (1 of 5)</fo:block> 
- <fo:block span="all" alignment-baseline="central">
  <fo:leader leader-length="890px" leader-pattern="rule" alignment-baseline="top" leader-pattern-width="4px" color="#cccccc" /> 
  </fo:block>
- <fo:block span="all" margin-left="8px" margin-right="8px">
- <fo:table>
- <fo:table-body>
- <fo:table-row>
- <fo:table-cell width="420px">
- <fo:block>
- <fo:table>
  <fo:table-column column-width="108px" /> 
  <fo:table-column /> 
- <fo:table-body>
- <fo:table-row height="13px">
- <fo:table-cell>
  <fo:block font="7pt ARIAL" color="#666666">Type</fo:block> 
  </fo:table-cell>
- <fo:table-cell>
  <fo:block font="9 PT ARIAL" color="#000000">Amendment:</fo:block> 
  </fo:table-cell>
  </fo:table-row>
- <fo:table-row height="13px">
- <fo:table-cell>
  <fo:block font="7pt ARIAL" color="#666666">Project Name</fo:block> 
  </fo:table-cell>
- <fo:table-cell>
- <fo:block>
  <fo:basic-link font="12pt ARIAL" color="#0033CC" text-decoration="underline" external-destination="url('http://www.google.com/')">Replace Domiciliary Building</fo:basic-link> 
  </fo:block>
  </fo:table-cell>
  </fo:table-row>
- <fo:table-row height="13px">
- <fo:table-cell>
  <fo:block font="7pt ARIAL" color="#666666">Submittal Date</fo:block> 
  </fo:table-cell>
- <fo:table-cell>
  <fo:block font="9 PT ARIAL" color="#000000">09/08/2008</fo:block> 
  </fo:table-cell>
  </fo:table-row>
  </fo:table-body>
  </fo:table>
  </fo:block>
  </fo:table-cell>
- <fo:table-cell padding-left="30px">
- <fo:block>
  <fo:external-graphic content-width="135px" src="url('Images\ResearchOnlline.gif')" /> 
  <fo:external-graphic content-width="135px" src="url('Images\PlanHolderList.gif')" /> 
  <fo:external-graphic content-width="135px" src="url('Images\BiddersList.gif')" /> 
  </fo:block>
  </fo:table-cell>
  </fo:table-row>
  </fo:table-body>
  </fo:table>
  </fo:block>
- <fo:block span="all" alignment-baseline="central">
  <fo:leader leader-length="890px" leader-pattern="rule" alignment-baseline="top" leader-pattern-width="2px" color="#CCCCCC" /> 
  </fo:block>
- <!-- Project details
  --> 
- <fo:block span="all" margin-left="8px" margin-right="8px">
- <fo:table>
- <fo:table-body>
- <fo:table-row>
- <fo:table-cell width="420px">
- <fo:block>
- <fo:table>
  <fo:table-column column-width="108px" /> 
  <fo:table-column /> 
- <fo:table-body>
- <fo:table-row height="13px">
- <fo:table-cell>
  <fo:block font="7pt ARIAL" color="#666666">Owner</fo:block> 
  </fo:table-cell>
- <fo:table-cell>
  <fo:block font="9pt ARIAL" color="#000000">US Department of Veterans Affairs, Northwest Health Network</fo:block> 
- <fo:block font="7pt ARIAL" color="#0033CC">
  [ 
  <fo:basic-link text-decoration="underline" external-destination="url('http://www.google.com/')">Owner Procurement History</fo:basic-link> 
  ] 
  </fo:block>
  </fo:table-cell>
  </fo:table-row>
- <fo:table-row height="13px">
- <fo:table-cell>
  <fo:block font="7pt ARIAL" color="#666666">Owner website</fo:block> 
  </fo:table-cell>
- <fo:table-cell>
- <fo:block font="9pt ARIAL" color="#0033CC">
  <fo:basic-link text-decoration="underline" external-destination="url('http://www.usva.gov/')">http://www.usva.gov</fo:basic-link> 
  </fo:block>
  </fo:table-cell>
  </fo:table-row>
- <fo:table-row height="13px">
- <fo:table-cell>
  <fo:block font="7pt ARIAL" color="#666666">Location</fo:block> 
  </fo:table-cell>
- <fo:table-cell>
  <fo:block font="9pt ARIAL" color="#000000">(1) VANCOUVER, WA</fo:block> 
  </fo:table-cell>
  </fo:table-row>
- <fo:table-row height="13px">
- <fo:table-cell>
  <fo:block font="7pt ARIAL" color="#666666">Zip Code</fo:block> 
  </fo:table-cell>
- <fo:table-cell>
  <fo:block font="9pt ARIAL" color="#000000">97503, 98662</fo:block> 
  </fo:table-cell>
  </fo:table-row>
- <fo:table-row height="13px">
- <fo:table-cell>
  <fo:block font="7pt ARIAL" color="#666666">County</fo:block> 
  </fo:table-cell>
- <fo:table-cell>
  <fo:block font="9pt ARIAL" color="#000000">JACKSON, OR; CLARK, WA</fo:block> 
  </fo:table-cell>
  </fo:table-row>
- <fo:table-row height="13px">
- <fo:table-cell>
  <fo:block font="7pt ARIAL" color="#666666">Value</fo:block> 
  </fo:table-cell>
- <fo:table-cell>
  <fo:block font="9pt ARIAL" color="#000000">$5,000,000.00 to $10,000,000.00</fo:block> 
  </fo:table-cell>
  </fo:table-row>
- <fo:table-row height="13px">
- <fo:table-cell>
  <fo:block /> 
  </fo:table-cell>
- <fo:table-cell>
  <fo:block /> 
  </fo:table-cell>
  </fo:table-row>
- <fo:table-row height="13px">
- <fo:table-cell>
  <fo:block font="7pt ARIAL" color="#666666">Market Sector</fo:block> 
  </fo:table-cell>
- <fo:table-cell>
  <fo:block font="9pt ARIAL" color="#000000">Federal</fo:block> 
  </fo:table-cell>
  </fo:table-row>
- <fo:table-row height="13px">
- <fo:table-cell>
  <fo:block font="7pt ARIAL" color="#666666">Buyer</fo:block> 
  </fo:table-cell>
- <fo:table-cell>
- <fo:block font="9pt ARIAL" color="#0033CC">
  <fo:basic-link text-decoration="underline" external-destination="url('mailto:Lorna.Craig@test.com')">Lorna Craig</fo:basic-link> 
  <fo:inline color="#000000">, Contracting Officer</fo:inline> 
  </fo:block>
- <fo:block font="7pt ARIAL" color="#0033CC">
  [ 
  <fo:basic-link text-decoration="underline" external-destination="url('http://www.google.com/')">Buyer Procurement History</fo:basic-link> 
  ] 
  </fo:block>
  </fo:table-cell>
  </fo:table-row>
- <fo:table-row height="13px">
- <fo:table-cell>
  <fo:block font="7pt ARIAL" color="#666666">Buyer Phone</fo:block> 
  </fo:table-cell>
- <fo:table-cell>
  <fo:block font="9pt ARIAL" color="#000000">(503) 220-8262</fo:block> 
  </fo:table-cell>
  </fo:table-row>
- <fo:table-row height="13px">
- <fo:table-cell>
  <fo:block /> 
  </fo:table-cell>
- <fo:table-cell>
  <fo:block /> 
  </fo:table-cell>
  </fo:table-row>
- <fo:table-row height="13px">
- <fo:table-cell>
  <fo:block font="7pt ARIAL" color="#666666">Onvia Ref Number</fo:block> 
  </fo:table-cell>
- <fo:table-cell>
  <fo:block font="9pt ARIAL" color="#000000">8057595 - 06/23/2008</fo:block> 
  </fo:table-cell>
  </fo:table-row>
- <fo:table-row height="13px">
- <fo:table-cell>
  <fo:block font="7pt ARIAL" color="#666666">Project Number</fo:block> 
  </fo:table-cell>
- <fo:table-cell>
  <fo:block font="9pt ARIAL" color="#000000">HSCG87-08-B-643027</fo:block> 
  </fo:table-cell>
  </fo:table-row>
- <fo:table-row height="13px" display-align="after">
- <fo:table-cell>
  <fo:block font="7pt ARIAL" color="#666666">Documents</fo:block> 
  </fo:table-cell>
- <fo:table-cell>
- <fo:block>
  <fo:external-graphic src="url('Images\Amendment.gif')" /> 
  <fo:basic-link font="9pt ARIAL" color="#0033CC" text-decoration="underline" external-destination="url('http://www.google.com/')">Amendment</fo:basic-link> 
  <fo:inline font="7pt ARIAL" margin-left="50px" color="#0033CC">Added 9/2/2008</fo:inline> 
  </fo:block>
  </fo:table-cell>
  </fo:table-row>
  </fo:table-body>
  </fo:table>
  </fo:block>
  </fo:table-cell>
- <fo:table-cell padding-left="30px">
- <fo:block>
  <fo:external-graphic content-width="267px" border="3px solid #cccccc" src="url('Images\GoogleMap.gif')" /> 
  </fo:block>
- <fo:block font="8pt ARIAL" color="#0033CC" vertical-align="middle">
  <fo:external-graphic content-width="30px" src="url('Images\print.gif')" /> 
  <fo:basic-link text-decoration="underline" external-destination="url('http://www.google.com/')">Print This</fo:basic-link> 
  <fo:external-graphic content-width="30px" src="url('Images\email.gif')" /> 
  <fo:basic-link text-decoration="underline" external-destination="url('http://www.google.com/')">Send This</fo:basic-link> 
  <fo:external-graphic content-width="30px" src="url('Images\rate.gif')" /> 
  <fo:basic-link text-decoration="underline" external-destination="url('http://www.google.com/')">Rate This</fo:basic-link> 
  </fo:block>
  </fo:table-cell>
  </fo:table-row>
  </fo:table-body>
  </fo:table>
  </fo:block>
- <fo:block span="all" alignment-baseline="central">
  <fo:leader leader-length="890px" leader-pattern="rule" alignment-baseline="top" leader-pattern-width="2px" color="#CCCCCC" /> 
  </fo:block>
- <!-- Project description
  --> 
- <fo:block margin-left="8px" margin-right="8px" font="9pt ARIAL">
  Y--Replace Domiciliary Building 218 Solicitation Number: VA-260-08-RP-0403 Agency: Department of Veterans Affairs Office: VA Northwest Health Network Location: VA Northwest Health Network General Information Original Posted Date:July 24, 2008 Posted Date: Aug 21, 2008 Res- ponse Date: September 8, 2008 Original Response Date: September 15,2008 Original Set Aside: N/A Set Aside: N/A Classification Code: Y -- 
  <fo:inline background-color="#FFFF00">Construction</fo:inline> 
  of structures and facilities NAICS Code: 236 -Commercial and Institutional Building 
  <fo:inline background-color="#FFFF00">Construction</fo:inline> 
  Contracting Office Address: Department of Veterans Affairs;VA NW Health Network (VISN 20);Vancouver Square at the Mall, Suite 203;5115NE 82nd AVE;Vancouver WA 98662 Place of Performance: Department of Veterans Affairs;Southern Oregon Rehabilitation Center and Clinics;8495 Crater Lake Hwy;White City, OR 97503 USA Solicitation Number: VA-260-08-RP- 0403 Notice Type:Modification/Amendment Please consult the list of document viewers if you cannot open a file. Point ofContact(s): Lorna CraigContracting Officer 503-220-8262 Lorna.Craig@va.gov ***Original Synopsis*** Synopsis: Added:Jul 24, 2008 6:53 pm Project Renovate Domiciliary Building 218 Project #692-333. The RFP will be issued on a full andopen basis for 
  <fo:inline background-color="#FFFF00">construction</fo:inline> 
  . The location is White City, Oregon. General 
  <fo:inline background-color="#FFFF00">Construction</fo:inline> 
  : Contractor shall furnish all necessary labor, material, and equipment to provide a complete building, including all utility systems, and associated components as shown on the drawings and described by the specifications. This includes, but is not limited to, demolition of existing structures, general 
  <fo:inline background-color="#FFFF00">construction</fo:inline> 
  , alterations, site development, landscaping, drainage, mechanical, electrical, and certain other items. Asbestos and lead paint removal are included in the project. The magnitude of 
  <fo:inline background-color="#FFFF00">construction</fo:inline> 
  is between $5,000,000 and$10,000,000. The RFP solicitation is anticipated to be issued on or about August 8, 2008, and offers will be due on orabout September 10, 2008. No public bid opening procedures are applicable to this solicitation. A firm fixed price contract is anticipated to be awarded using Best Value evaluation criteria. Anticipated award date is September 20, 2008. 
  </fo:block>
  </fo:flow>
  </fo:page-sequence>
- <!-- Project Details(Pre-Planning)
  --> 
- <fo:page-sequence master-reference="PagingAll" id="PrePlanning">
- <fo:static-content flow-name="xsl-region-after" width="100%">
  <fo:block margin-left="8px" margin-right="8px" font="5pt ARIAL" color="#666666">The Onvia Guide © 2008 Onvia, Inc. All rights are reserved. Unless you have a multiple site or multiple office license with Onvia, only you alone can use The Onvia Guide at asingle location. Without the written consent of Onvia, you cannot modify, copy, display, reproduce, share, sell, publish, transfer, assign, or distribute The Onvia Guide or anyportion thereof. For any questions regarding licenses to your other office locations, please contact Onvia Customer Service at (888)484-3374 or customerservice@onvia.com</fo:block> 
- <fo:block text-align="right">
- <fo:inline text-align="right" color="#000000" font="5pt ARIAL">
  <fo:page-number /> 
  </fo:inline>
  </fo:block>
  </fo:static-content>
- <fo:flow flow-name="xsl-region-body">
- <!-- Header Image
  --> 
- <fo:block-container span="all" width="890px" background-image="url('Images\GuideCoverTopBar.gif')" height="47px" background-repeat="no-repeat" display-align="center">
- <fo:block margin-left="250px">
- <fo:table>
- <fo:table-body>
- <fo:table-row>
- <fo:table-cell width="500px">
  <fo:block font="14pt ARIAL" color="#FFFFFF">Daily Guide, August 28, 2008</fo:block> 
  </fo:table-cell>
- <fo:table-cell>
  <fo:block font="7pt ARIAL" color="#FFFFFF">Volume 16, Issue 169</fo:block> 
  </fo:table-cell>
  </fo:table-row>
  </fo:table-body>
  </fo:table>
  </fo:block>
  </fo:block-container>
- <!-- Subscriber Details
  --> 
- <fo:block span="all">
- <fo:table>
- <fo:table-body>
- <fo:table-row>
- <fo:table-cell width="660px">
  <fo:block font="9pt ARIAL" color="#000000">Michael Johnson, Johnson Construction, LLC, Eugene, OR</fo:block> 
  </fo:table-cell>
- <fo:table-cell>
- <fo:block>
- <fo:table font="7pt ARIAL #666666">
  <fo:table-column column-width="140px" /> 
  <fo:table-column column-width="120px" /> 
- <fo:table-body>
- <fo:table-row>
- <fo:table-cell>
  <fo:block font="7pt ARIAL" color="#000000">Onvia Account Executive:</fo:block> 
  </fo:table-cell>
- <fo:table-cell>
  <fo:block font="7pt ARIAL" color="#0033CC" text-decoration="underline">Jane Smolyenko</fo:block> 
  </fo:table-cell>
  </fo:table-row>
- <fo:table-row>
- <fo:table-cell>
  <fo:block font="7pt ARIAL" color="#000000">Phone:</fo:block> 
  </fo:table-cell>
- <fo:table-cell>
  <fo:block>(888) 3934567</fo:block> 
  </fo:table-cell>
  </fo:table-row>
  </fo:table-body>
  </fo:table>
  </fo:block>
  </fo:table-cell>
  </fo:table-row>
  </fo:table-body>
  </fo:table>
  </fo:block>
- <!-- Subscriber Footer
  --> 
- <fo:block span="all">
  <fo:external-graphic content-width="890px" src="url('Images\GreyHorizontalBar.gif')" /> 
  </fo:block>
- <!-- Saved Search Title
  --> 
- <fo:block alignment-baseline="central" margin-left="5px" margin-right="5px" span="all">
- <fo:table width="480px">
- <fo:table-body>
- <fo:table-row height="11px" margin-top="7px">
- <fo:table-cell>
  <fo:block font="7pt ARIAL" color="#666666">Saved Search 1</fo:block> 
  </fo:table-cell>
  </fo:table-row>
- <fo:table-row height="19px">
- <fo:table-cell number-columns-spanned="2">
  <fo:block font="14pt ARIAL" color="#000000" text-align="left">A & E Oregon (1 of 5)</fo:block> 
  </fo:table-cell>
  </fo:table-row>
  </fo:table-body>
  </fo:table>
  </fo:block>
- <!-- line break
  --> 
- <fo:block alignment-baseline="central" span="all">
  <fo:leader leader-length="100%" leader-pattern="rule" alignment-baseline="middle" rule-thickness="1px" color="#CCCCCC" /> 
  </fo:block>
- <!-- Project title
  --> 
- <fo:block span="all" margin-left="8px" margin-right="8px">
- <fo:table>
- <fo:table-body>
- <fo:table-row>
- <fo:table-cell width="420px">
- <fo:block>
- <fo:table>
  <fo:table-column column-width="108px" /> 
  <fo:table-column /> 
- <fo:table-body>
- <fo:table-row height="13px">
- <fo:table-cell>
  <fo:block font="7pt ARIAL" color="#666666">Type</fo:block> 
  </fo:table-cell>
- <fo:table-cell>
  <fo:block font="9 PT ARIAL" color="#000000">Pre Planning</fo:block> 
  </fo:table-cell>
  </fo:table-row>
- <fo:table-row height="13px">
- <fo:table-cell>
  <fo:block font="7pt ARIAL" color="#666666">Project Name</fo:block> 
  </fo:table-cell>
- <fo:table-cell>
- <fo:block>
  <fo:basic-link font="12pt ARIAL" color="#0033CC" text-decoration="underline" external-destination="url('http://www.google.com/')">Steptoe Garden Co., Lp</fo:basic-link> 
  </fo:block>
  </fo:table-cell>
  </fo:table-row>
  </fo:table-body>
  </fo:table>
  </fo:block>
  </fo:table-cell>
- <fo:table-cell padding-left="30px">
- <fo:block>
  <fo:external-graphic content-width="135px" src="url('Images\ResearchOnlline.gif')" /> 
  </fo:block>
  </fo:table-cell>
  </fo:table-row>
  </fo:table-body>
  </fo:table>
  </fo:block>
- <!-- Line Break
  --> 
- <fo:block span="all">
  <fo:leader leader-length="100%" leader-pattern="rule" alignment-baseline="middle" rule-thickness="1px" color="#CCCCCC" /> 
  </fo:block>
- <!-- Project details
  --> 
- <fo:block span="all" margin-left="8px" margin-right="8px">
- <fo:table>
- <fo:table-body>
- <fo:table-row>
- <fo:table-cell width="420px">
- <fo:block>
- <fo:table>
  <fo:table-column column-width="108px" /> 
  <fo:table-column /> 
- <fo:table-body>
- <fo:table-row height="13px">
- <fo:table-cell>
  <fo:block font="7pt ARIAL" color="#666666">Location:</fo:block> 
  </fo:table-cell>
- <fo:table-cell>
  <fo:block font="9pt ARIAL" color="#000000">CLARK County, NV</fo:block> 
  </fo:table-cell>
  </fo:table-row>
- <fo:table-row height="13px">
- <fo:table-cell>
  <fo:block font="7pt ARIAL" color="#666666">Publication Date:</fo:block> 
  </fo:table-cell>
- <fo:table-cell>
  <fo:block font="9pt ARIAL" color="#000000">6/1/2007</fo:block> 
  </fo:table-cell>
  </fo:table-row>
- <fo:table-row height="35px">
- <fo:table-cell>
  <fo:block font="7pt ARIAL" color="#666666">Meeting Date:</fo:block> 
  </fo:table-cell>
- <fo:table-cell>
  <fo:block font="9pt ARIAL" color="#000000">3/6/2007</fo:block> 
  </fo:table-cell>
  </fo:table-row>
- <fo:table-row height="13px">
- <fo:table-cell>
  <fo:block font="7pt ARIAL" color="#666666">Development Type:</fo:block> 
  </fo:table-cell>
- <fo:table-cell>
  <fo:block font="9pt ARIAL" color="#000000">Residential</fo:block> 
  </fo:table-cell>
  </fo:table-row>
- <fo:table-row height="13px">
- <fo:table-cell>
  <fo:block font="7pt ARIAL" color="#666666">Proposed Product:</fo:block> 
  </fo:table-cell>
- <fo:table-cell>
  <fo:block font="9pt ARIAL" color="#000000">Acers - 5.1</fo:block> 
  </fo:table-cell>
  </fo:table-row>
- <fo:table-row height="13px">
- <fo:table-cell>
  <fo:block font="7pt ARIAL" color="#666666">Entitlement Status:</fo:block> 
  </fo:table-cell>
- <fo:table-cell>
  <fo:block font="9pt ARIAL" color="#000000">Conceptual Plan Submitted</fo:block> 
  </fo:table-cell>
  </fo:table-row>
- <fo:table-row height="13px">
- <fo:table-cell>
  <fo:block font="7pt ARIAL" color="#666666">Project Address:</fo:block> 
  </fo:table-cell>
- <fo:table-cell>
  <fo:block font="9pt ARIAL" color="#000000">(1) East Side of Steptoe Street and the North Side of Hamilton Avenue Within Whitney, NV</fo:block> 
  </fo:table-cell>
  </fo:table-row>
- <fo:table-row height="13px">
- <fo:table-cell>
  <fo:block /> 
  </fo:table-cell>
- <fo:table-cell>
  <fo:block /> 
  </fo:table-cell>
  </fo:table-row>
- <fo:table-row height="13px">
- <fo:table-cell>
  <fo:block font="7pt ARIAL" color="#666666">Zoning Change:</fo:block> 
  </fo:table-cell>
- <fo:table-cell>
  <fo:block font="9pt ARIAL" color="#000000">No</fo:block> 
  </fo:table-cell>
  </fo:table-row>
- <fo:table-row height="13px">
- <fo:table-cell>
  <fo:block font="7pt ARIAL" color="#666666">Notes:</fo:block> 
  </fo:table-cell>
- <fo:table-cell>
  <fo:block font="9pt ARIAL" color="#000000">RUD (Residential Urban Density) Zone</fo:block> 
  </fo:table-cell>
  </fo:table-row>
- <fo:table-row height="13px">
- <fo:table-cell>
  <fo:block /> 
  </fo:table-cell>
- <fo:table-cell>
  <fo:block /> 
  </fo:table-cell>
  </fo:table-row>
- <fo:table-row height="13px">
- <fo:table-cell>
  <fo:block font="7pt ARIAL" color="#666666">Contact</fo:block> 
  </fo:table-cell>
- <fo:table-cell>
  <fo:block font="9pt ARIAL" color="#000000">Civiltec, Inc</fo:block> 
  </fo:table-cell>
  </fo:table-row>
- <fo:table-row height="13px">
- <fo:table-cell>
  <fo:block font="7pt ARIAL" color="#666666">Address:</fo:block> 
  </fo:table-cell>
- <fo:table-cell>
  <fo:block font="9pt ARIAL" color="#000000">70 East Horizon Ridge Parkway,Suite 190, Henderson,NV,89002</fo:block> 
  </fo:table-cell>
  </fo:table-row>
- <fo:table-row height="13px">
- <fo:table-cell>
  <fo:block /> 
  </fo:table-cell>
- <fo:table-cell>
  <fo:block /> 
  </fo:table-cell>
  </fo:table-row>
- <fo:table-row height="13px">
- <fo:table-cell>
  <fo:block font="7pt ARIAL" color="#666666">Name:</fo:block> 
  </fo:table-cell>
- <fo:table-cell>
  <fo:block font="9pt ARIAL" color="#000000">Paulette Stacy</fo:block> 
  </fo:table-cell>
  </fo:table-row>
- <fo:table-row height="13px">
- <fo:table-cell>
  <fo:block font="7pt ARIAL" color="#666666">Contact:</fo:block> 
  </fo:table-cell>
- <fo:table-cell>
  <fo:block font="9pt ARIAL" color="#000000">Steptoe Garden Co., Lp</fo:block> 
  </fo:table-cell>
  </fo:table-row>
- <fo:table-row height="13px">
- <fo:table-cell>
  <fo:block font="7pt ARIAL" color="#666666">Role:</fo:block> 
  </fo:table-cell>
- <fo:table-cell>
  <fo:block font="9pt ARIAL" color="#000000">Applicant, Owner</fo:block> 
  </fo:table-cell>
  </fo:table-row>
- <fo:table-row height="13px">
- <fo:table-cell>
  <fo:block font="7pt ARIAL" color="#666666">Address:</fo:block> 
  </fo:table-cell>
- <fo:table-cell>
  <fo:block font="9pt ARIAL" color="#000000">5070 Tara Ave,#116,Las Vegas,NV,89146</fo:block> 
  </fo:table-cell>
  </fo:table-row>
- <fo:table-row height="13px">
- <fo:table-cell>
  <fo:block font="7pt ARIAL" color="#666666">Name:</fo:block> 
  </fo:table-cell>
- <fo:table-cell>
  <fo:block font="9pt ARIAL" color="#000000">Steven Grandview</fo:block> 
  </fo:table-cell>
  </fo:table-row>
- <fo:table-row height="13px">
- <fo:table-cell>
  <fo:block font="7pt ARIAL" color="#666666">Title:</fo:block> 
  </fo:table-cell>
- <fo:table-cell>
  <fo:block font="9pt ARIAL" color="#000000">Vice President</fo:block> 
  </fo:table-cell>
  </fo:table-row>
- <fo:table-row height="13px">
- <fo:table-cell>
  <fo:block font="7pt ARIAL" color="#666666">Department:</fo:block> 
  </fo:table-cell>
- <fo:table-cell>
  <fo:block font="9pt ARIAL" color="#000000">Engineering</fo:block> 
  </fo:table-cell>
  </fo:table-row>
- <fo:table-row height="13px">
- <fo:table-cell>
  <fo:block font="7pt ARIAL" color="#666666">Phone:</fo:block> 
  </fo:table-cell>
- <fo:table-cell>
  <fo:block font="9pt ARIAL" color="#000000">(589) 555-5678</fo:block> 
  </fo:table-cell>
  </fo:table-row>
- <fo:table-row height="13px">
- <fo:table-cell>
  <fo:block font="7pt ARIAL" color="#666666">Fax:</fo:block> 
  </fo:table-cell>
- <fo:table-cell>
  <fo:block font="9pt ARIAL" color="#000000">(589) 555-5600</fo:block> 
  </fo:table-cell>
  </fo:table-row>
- <fo:table-row height="13px">
- <fo:table-cell>
  <fo:block font="7pt ARIAL" color="#666666">Email:</fo:block> 
  </fo:table-cell>
- <fo:table-cell>
- <fo:block font="9pt ARIAL" color="#0033CC">
  <fo:basic-link text-decoration="underline" external-destination="url('mailto:Steven.Grandview@Steptoe.com')">Steven.Grandview@Steptoe.com</fo:basic-link> 
  </fo:block>
  </fo:table-cell>
  </fo:table-row>
- <fo:table-row height="13px">
- <fo:table-cell>
  <fo:block /> 
  </fo:table-cell>
- <fo:table-cell>
  <fo:block /> 
  </fo:table-cell>
  </fo:table-row>
- <fo:table-row height="13px">
- <fo:table-cell>
  <fo:block font="7pt ARIAL" color="#666666">Planning Officials:</fo:block> 
  </fo:table-cell>
- <fo:table-cell>
  <fo:block font="9pt ARIAL" color="#000000">CLARK - Planning Commission</fo:block> 
  </fo:table-cell>
  </fo:table-row>
- <fo:table-row height="13px">
- <fo:table-cell>
  <fo:block font="7pt ARIAL" color="#666666">Address:</fo:block> 
  </fo:table-cell>
- <fo:table-cell>
  <fo:block font="9pt ARIAL" color="#000000">500 S. Grand Central Pkwy., P.O. Box 551744 "89155-1744", , NV 89155</fo:block> 
  </fo:table-cell>
  </fo:table-row>
- <fo:table-row height="13px">
- <fo:table-cell>
  <fo:block font="7pt ARIAL" color="#666666">Website:</fo:block> 
  </fo:table-cell>
- <fo:table-cell>
- <fo:block font="9pt ARIAL" color="#0033CC">
  <fo:basic-link text-decoration="underline" external-destination="url('http://dsnet.co.clark.nv.us/')">http://dsnet.co.clark.nv.us/</fo:basic-link> 
  </fo:block>
- <fo:block font="7pt ARIAL" color="#0033CC">
  [ 
  <fo:basic-link text-decoration="underline" external-destination="url('http://www.google.com/')">Planning Official Contacts</fo:basic-link> 
  ] 
  </fo:block>
  </fo:table-cell>
  </fo:table-row>
- <fo:table-row height="13px">
- <fo:table-cell>
  <fo:block /> 
  </fo:table-cell>
- <fo:table-cell>
  <fo:block /> 
  </fo:table-cell>
  </fo:table-row>
- <fo:table-row height="13px">
- <fo:table-cell>
  <fo:block font="7pt ARIAL" color="#666666">Project File #:</fo:block> 
  </fo:table-cell>
- <fo:table-cell>
  <fo:block font="9pt ARIAL" color="#000000">LU 08-0014,LU 00-0071, LUO3-0009</fo:block> 
  </fo:table-cell>
  </fo:table-row>
- <fo:table-row height="13px">
- <fo:table-cell>
  <fo:block font="7pt ARIAL" color="#666666">APN #:</fo:block> 
  </fo:table-cell>
- <fo:table-cell>
  <fo:block font="9pt ARIAL" color="#000000">21E O8BB</fo:block> 
  </fo:table-cell>
  </fo:table-row>
- <fo:table-row height="13px">
- <fo:table-cell>
  <fo:block font="7pt ARIAL" color="#666666">Onvia Number:</fo:block> 
  </fo:table-cell>
- <fo:table-cell>
  <fo:block font="9pt ARIAL" color="#000000">408454443</fo:block> 
  </fo:table-cell>
  </fo:table-row>
- <fo:table-row height="13px" display-align="after">
- <fo:table-cell>
  <fo:block font="7pt ARIAL" color="#666666">Documents</fo:block> 
  </fo:table-cell>
- <fo:table-cell>
- <fo:block>
  <fo:external-graphic src="url('Images\Amendment.gif')" /> 
  <fo:basic-link font="9pt ARIAL" color="#0033CC" text-decoration="underline" external-destination="url('http://www.google.com/')">Council Document</fo:basic-link> 
  <fo:inline font="7pt ARIAL" margin-left="50px" color="#0033CC" white-space-collapse="false">Added 9/2/2008</fo:inline> 
  </fo:block>
  </fo:table-cell>
  </fo:table-row>
  </fo:table-body>
  </fo:table>
  </fo:block>
  </fo:table-cell>
- <fo:table-cell padding-left="30px">
- <fo:block>
  <fo:external-graphic content-width="267px" border="3px solid #cccccc" src="url('Images\GoogleMap.gif')" /> 
  </fo:block>
- <fo:block font="8pt ARIAL" color="#0033CC" vertical-align="middle">
  <fo:external-graphic content-width="30px" src="url('Images\print.gif')" /> 
  <fo:basic-link text-decoration="underline" external-destination="url('http://www.google.com/')">Print This</fo:basic-link> 
  <fo:external-graphic content-width="30px" src="url('Images\email.gif')" /> 
  <fo:basic-link text-decoration="underline" external-destination="url('http://www.google.com/')">Send This</fo:basic-link> 
  <fo:external-graphic content-width="30px" src="url('Images\rate.gif')" /> 
  <fo:basic-link text-decoration="underline" external-destination="url('http://www.google.com/')">Rate This</fo:basic-link> 
  </fo:block>
  </fo:table-cell>
  </fo:table-row>
  </fo:table-body>
  </fo:table>
  </fo:block>
- <fo:block span="all" alignment-baseline="central">
  <fo:leader leader-length="890px" leader-pattern="rule" alignment-baseline="top" leader-pattern-width="2px" color="#CCCCCC" /> 
  </fo:block>
- <!-- Project description
  --> 
  <fo:block margin-left="8px" margin-right="8px" font="9pt ARIAL">UC-1723-06 STEPTOE GARDEN CO., LP:USE PERMIT for a planned unit development.DESIGN REVIEW for site layout and model design on 5.1 acres in an RUD (Residential Urban Density) Zone. Generally located on the east side of Steptoe Street and the north side of Hamilton Avenue within Whitney.</fo:block> 
  </fo:flow>
  </fo:page-sequence>
  </fo:root>