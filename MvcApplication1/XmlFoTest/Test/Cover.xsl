<?xml version='1.0' encoding='ISO-8859-1'?>

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:fo="http://www.w3.org/1999/XSL/Format" xmlns:rx="http://www.renderx.com/XSL/Extensions" version="1.0">

<xsl:output method="xml" version="1.0" encoding="ISO-8859-1"/>

<xsl:template match="vce/list">
  <fo:root>
    <fo:layout-master-set>
		<!--Master details for Project Details section-->
		<fo:simple-page-master master-name="project-details" page-width="1010px" margin-top="60px" margin-bottom="80px" 
			margin-left="60px"  margin-right="60px">
			<!--body-->
			<fo:region-body column-count="2" reference-orientation="0" column-gap="30px" margin-bottom="40px"/>
			<!--footer-->
			<fo:region-after extent="5px"/>
		</fo:simple-page-master>
		
		<fo:page-sequence-master master-name="PagingAll">
			<fo:repeatable-page-master-reference master-reference="project-details"/>
		</fo:page-sequence-master>
	</fo:layout-master-set>

  <!--PageCover-->
	<fo:page-sequence master-reference="PagingAll">
		<fo:static-content flow-name="xsl-region-after">
			<fo:block margin-left="8px" margin-right="8px" font="5pt ARIAL" color="#666666">The Onvia Guide © 2008 Onvia, Inc. All rights are reserved. Unless you have a multiple site or multiple office license with Onvia, only you alone can use The Onvia Guide at asingle location. Without the written consent of Onvia, you cannot modify, copy, display, reproduce, share, sell, publish, transfer, assign, or distribute The Onvia Guide or anyportion thereof. For any questions regarding licenses to your other office locations, please contact Onvia Customer Service at (888)484-3374 or customerservice@onvia.com
			</fo:block>
		</fo:static-content>
		<fo:flow flow-name="xsl-region-body" span="all">
			<!--Header Image-->
			<fo:block>
				<fo:external-graphic content-width="890px" src="url('Images\GuideCoverTopBar.gif')"/>
			</fo:block>
			<fo:block margin-left="350px" span="all">
				<fo:block margin-top="35px" font="10pt ARIAL" height="=58px" vertical-align="top">volume 
					<xsl:apply-templates select="cover/content[@name='volume']/text()"></xsl:apply-templates>
					, number
					<xsl:apply-templates select="cover/content[@name='number']/text()"></xsl:apply-templates>
				</fo:block>
				<fo:block margin-top="10px" linefeed-treatment="preserve" font="22pt ARIAL" height="41px" vertical-align="top">
					<xsl:apply-templates select="cover/content[@name='subscriptionType']/text()"></xsl:apply-templates> Guide
				 </fo:block>
				<fo:block margin-top="7px" linefeed-treatment="preserve" font="22pt ARIAL" height="41px" vertical-align="top">
					<xsl:apply-templates select="cover/content[@name='subscriptionDate']/text()"></xsl:apply-templates>
				</fo:block>
				<fo:block margin-top="15px" border="1px solid #ccc"/>
				<fo:block margin-top="15px" linefeed-treatment="preserve" font="16pt ARIAL" height="42px">
					<xsl:apply-templates select="cover/content[@name='name']/text()"></xsl:apply-templates>
				</fo:block>
				<fo:block margin-top="10px" linefeed-treatment="preserve" font="16pt ARIAL" height="42px">
					<xsl:apply-templates select="cover/content[@name='company']/text()"></xsl:apply-templates>,
				</fo:block>
				<fo:block margin-top="10px" linefeed-treatment="preserve" font="16pt ARIAL" height="42px" vertical-align="top">
					<xsl:apply-templates select="cover/content[@name='city']/text()"></xsl:apply-templates>, <xsl:apply-templates select="cover/content[@name='state']/text()"></xsl:apply-templates>
				</fo:block>
				<fo:block margin-top="18px" border="1px solid #ccc"/>
				
				<xsl:for-each select="cover/content[@name='vertical']">
				<fo:block margin-top="18px" linefeed-treatment="preserve" font="15pt ARIAL" height="200px"><xsl:value-of select="./@id"/></fo:block>
				<fo:block linefeed-treatment="preserve" font="9pt ARIAL" height="42px"><xsl:value-of select="text()"/></fo:block>
				<fo:block margin-top="10px" border="1px solid #ccc"/>
				</xsl:for-each>
			</fo:block>
		</fo:flow>
	</fo:page-sequence>
	
	<!--Table of Contents-->
	<fo:page-sequence master-reference="PagingAll">
		<!--footer-->
		<fo:static-content flow-name="xsl-region-after">
			<fo:block margin-left="8px" margin-right="8px" font="5pt ARIAL" color="#666666">The Onvia Guide © 2008 Onvia, Inc. All rights are reserved. Unless you have a multiple site or multiple office license with Onvia, only you alone can use The Onvia Guide at asingle location. Without the written consent of Onvia, you cannot modify, copy, display, reproduce, share, sell, publish, transfer, assign, or distribute The Onvia Guide or anyportion thereof. For any questions regarding licenses to your other office locations, please contact Onvia Customer Service at (888)484-3374 or customerservice@onvia.com</fo:block>
		</fo:static-content>
		<!--body-->
		<fo:flow flow-name="xsl-region-body">
			<fo:block-container width="890px" background-image="url('Images\GuideHeaderLarge.gif')" height="148px" display-align="after" >
				<fo:block margin-left="450px" margin-bottom="28px" font="14pt ARIAL" color="#FFFFFF">Daily Guide, August 28, 2008       
					<fo:inline font="7pt ARIAL" color="#000000">Volume 16, Issue 169</fo:inline></fo:block>
			</fo:block-container>
	
		<fo:block margin-top="8px" margin-left="5px" span="all">
			<fo:table>
				<fo:table-body>
					<fo:table-row>
						<fo:table-cell width="350px">
							<fo:block font="14pt ARIAL">Michael Johnson</fo:block>
							<fo:block font="9pt ARIAL">Johnson Construction, LLC</fo:block>
							<fo:block font="9pt ARIAL">Eugene, Oregon</fo:block>
							<fo:block font="7pt" color="#0033CC">
								<fo:basic-link external-destination="url('http://www.google.com/')" text-decoration="underline">[ Manage Profile ]</fo:basic-link>
							</fo:block>
						</fo:table-cell>
						<fo:table-cell width="220px">
							<fo:table font="7pt ARIAL" color="#666">
								<fo:table-column column-width="130px"/>
								<fo:table-column column-width="160px"/>
								<fo:table-body>
									<fo:table-row>
										<fo:table-cell>
											<fo:block color="#666">Subscription: </fo:block>
										</fo:table-cell>
										<fo:table-cell>
											<fo:block>
												End 11/15/08, <fo:basic-link external-destination="url('http://www.RenderX.com/')" text-decoration="underline" color="blue">Renew Now</fo:basic-link>
											</fo:block>
										</fo:table-cell>
									</fo:table-row>
									<fo:table-row>
										<fo:table-cell>
											<fo:block color="#666">locations: </fo:block>
										</fo:table-cell>
										<fo:table-cell>
											<fo:block color="#000">OR, WA</fo:block>
										</fo:table-cell>
									</fo:table-row>
									<fo:table-row>
										<fo:table-cell>
											<fo:block color="#666">Onvia Account: </fo:block>
										</fo:table-cell>
										<fo:table-cell>
											<fo:block color="#000">7182733</fo:block>
										</fo:table-cell>
									</fo:table-row>
									<fo:table-row>
										<fo:table-cell>
											<fo:block color="#666">Executive: </fo:block>
										</fo:table-cell>
										<fo:table-cell>
											<fo:block color="#000">Ronald McDonald</fo:block>
										</fo:table-cell>
									</fo:table-row>
									<fo:table-row>
										<fo:table-cell>
											<fo:block color="#666">Phone: </fo:block>
										</fo:table-cell>
										<fo:table-cell>
											<fo:block color="#000">(888) 393-4567</fo:block>
										</fo:table-cell>
									</fo:table-row>
								</fo:table-body>
							</fo:table>
						</fo:table-cell>
						<fo:table-cell>
							<fo:block>
								<fo:external-graphic src="url('Images\GoToOnlineGuide.gif')" content-width="220px"/>
							</fo:block>
						</fo:table-cell>
					</fo:table-row>
				</fo:table-body>
			</fo:table>
			</fo:block>
			<fo:block  margin-top="10px" span="all">
				<fo:external-graphic src="url('Images\GreyHorizontalBar.gif')" content-width="890px"/>
			</fo:block>
			<fo:block  margin-top="20px" span="all">
				<fo:table>
					<fo:table-column column-width="300px"/>
					<fo:table-column column-width="500px"/>
					<fo:table-body>
						<fo:table-row>
							<fo:table-cell>
								<fo:block font="14pt ARIAL">Product News</fo:block>
								<fo:block margin-top="15px" margin-right="50px"  border="1px solid #ccc"/>
								<fo:block margin-right="50px" padding-top="6px" font="9pt ARIAL" linefeed-treatment="preserve">
									<fo:inline font="11pt ARIAL">Oregon State Launches 15 New Projects in November</fo:inline> Across the education and healthcare markets and requiring A and E and construction assistance, The State of Oregon announced 15 new initiatives totalling over 18 milion dollars.
                </fo:block>
								<fo:block margin-top="15px" margin-right="50px" border="1px solid #ccc"/>
								<fo:block margin-right="50px" padding-top="9px" font="9pt ARIAL" linefeed-treatment="preserve">
									<fo:inline font="11pt ARIAL">Getting Wired</fo:inline>
<fo:block margin-right="50px"  font="9pt ARIAL">Onvia was featured in Wired Magazine in October. Read what 5 customers said about "Finding what you are looking for." Vice President of Product Michael Balsam is quoted " Our Success is really all about how smart we can be with data... content"</fo:block>
                </fo:block>
								<fo:block margin-top="15px" margin-right="50px" border="1px solid #ccc"/>
								<fo:block margin-right="50px" padding-top="9px" font="9pt ARIAL" linefeed-treatment="preserve">
									<fo:inline font="11pt ARIAL" linefeed-treatment="preserve">6 Million and Growing</fo:inline>
									<fo:block margin-right="50px"  font="9pt ARIAL">we have over 6 million records now and growing fast. With the demand for more accurate and timely public and private sector data, Onvia is increasing the number of sources and resources we apply to the task. Notable additions to our already robust dataset include.
									</fo:block>
                </fo:block>
								<fo:block margin-top="15px" margin-right="50px" border="1px solid #ccc"/>
							</fo:table-cell>
							<fo:table-cell>
								<fo:block font="14pt ARIAL">Contents</fo:block>
								<fo:table margin-top="10px">
									<fo:table-column column-width="340px"/>
									<fo:table-body>
										<fo:table-row>
											<fo:table-cell>
												<fo:block font="7pt" color="#666666">Item</fo:block>
											</fo:table-cell>
											<fo:table-cell>
												<fo:block font="7pt" color="#666666">Page</fo:block>
											</fo:table-cell>
										</fo:table-row>
									</fo:table-body>
								</fo:table>
								<fo:block margin-right="50px" border="1px solid #ccc"/>
								<fo:block padding-top="9px" font="10pt ARIAL">Your Saved Searches</fo:block>
								<fo:block font="7pt ARIAL" color="#0033CC" padding-top="3px">
									[ 
									<fo:basic-link  text-decoration="underline" external-destination="url('http://www.google.com/')">Manage Saved Searches</fo:basic-link>
									 ]
								</fo:block>
								<fo:table>
									<fo:table-body>
										<fo:table-row>
											<fo:table-cell>
												<fo:table margin-top="10px">
													<fo:table-column column-width="50px"/>
													<fo:table-column column-width="150px"/>
													<fo:table-column column-width="150px"/>
													<fo:table-body>
														<fo:table-row>
															<fo:table-cell>
																<fo:block>1 - </fo:block>
															</fo:table-cell>
															<fo:table-cell font="9pt ARIAL" padding-bottom="5px">
																<fo:block>
																	<fo:basic-link external-destination="url('http://www.RenderX.com/')" text-decoration="underline" color="blue">A and E Oregon</fo:basic-link>
																</fo:block>
																<fo:block>
																	<fo:basic-link external-destination="url('http://www.RenderX.com/')" text-decoration="underline" color="blue">RFP/RFQ/RFI - (1)</fo:basic-link>
																</fo:block>
																<fo:block>
																	<fo:basic-link internal-destination="PrePlanning" text-decoration="underline" color="blue">Pre Planning - (1)</fo:basic-link>
																</fo:block>
																<fo:block>
																	<fo:basic-link internal-destination="Amendment" text-decoration="underline" color="blue">Amendment - (3)</fo:basic-link>
																</fo:block>
															</fo:table-cell>
															<fo:table-cell>
																<fo:block/>
															</fo:table-cell>
															<fo:table-cell font="9pt ARIAL">
																<fo:block>
																	<fo:basic-link internal-destination="PrePlanning" text-decoration="underline" color="blue">4-9</fo:basic-link>
																</fo:block>
															</fo:table-cell>
														</fo:table-row>
														<fo:table-row>
															<fo:table-cell>
																<fo:block>2 - </fo:block>
															</fo:table-cell>
															<fo:table-cell font="9pt ARIAL" padding-bottom="5px">
																<fo:block>
																	<fo:basic-link external-destination="url('http://www.RenderX.com/')" text-decoration="underline" color="blue">A and E Oregon</fo:basic-link>
																</fo:block>
																<fo:block>
																	<fo:basic-link external-destination="url('http://www.RenderX.com/')" text-decoration="underline" color="blue">RFP/RFQ/RFI - (1)</fo:basic-link>
																</fo:block>
																<fo:block>
																	<fo:basic-link internal-destination="PrePlanning" text-decoration="underline" color="blue">Pre Planning - (1)</fo:basic-link>
																</fo:block>
																<fo:block>
																	<fo:basic-link internal-destination="Amendment" text-decoration="underline" color="blue">Amendment - (3)</fo:basic-link>
																</fo:block>
															</fo:table-cell>
															<fo:table-cell>
																<fo:block/>
															</fo:table-cell>
															<fo:table-cell font="9pt ARIAL">
																<fo:block>
																	<fo:basic-link internal-destination="Amendment" text-decoration="underline" color="blue">10-15</fo:basic-link>
																</fo:block>
															</fo:table-cell>
														</fo:table-row>														
													</fo:table-body>
												</fo:table>
												<fo:block span="all">
													<fo:leader leader-length="100%" leader-pattern="rule" alignment-baseline="middle" rule-thickness="2px" color="#CCCCCC"/>
												</fo:block>												
												<fo:table span="all">
													<fo:table-column column-width="350px"/>
													<fo:table-column column-width="150px"/>
													<fo:table-body>
														<fo:table-row padding-top="10px" padding-bottom="10px">
															<fo:table-cell>
																<fo:block margin-left="6px">Index of Organizations</fo:block>
															</fo:table-cell>
															<fo:table-cell font="9pt ARIAL">
																<fo:block>
																	<fo:basic-link internal-destination="0" text-decoration="underline" color="blue">16-17</fo:basic-link>
																</fo:block>
															</fo:table-cell>															
														</fo:table-row>
													</fo:table-body>
												</fo:table>
												<fo:block span="all">
													<fo:leader leader-length="100%" leader-pattern="rule" alignment-baseline="middle" rule-thickness="2px" color="#CCCCCC"/>
												</fo:block>
											</fo:table-cell>
											<fo:table-cell>
												<fo:block/>
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
	
		<!--Project details(Amendment)-->
	<xsl:for-each select="document">
		<xsl:choose>
			<xsl:when test="content[@name='type']/text() ='Amendment'">
				<fo:page-sequence master-reference="PagingAll" format="1">
		<fo:static-content flow-name="xsl-region-after" >
			<fo:block margin-left="8px" margin-right="8px" font="5pt ARIAL" color="#666666">The Onvia Guide © 2008 Onvia, Inc. All rights are reserved. Unless you have a multiple site or multiple office license with Onvia, only you alone can use The Onvia Guide at asingle location. Without the written consent of Onvia, you cannot modify, copy, display, reproduce, share, sell, publish, transfer, assign, or distribute The Onvia Guide or anyportion thereof. For any questions regarding licenses to your other office locations, please contact Onvia Customer Service at (888)484-3374 or customerservice@onvia.com</fo:block>
			<fo:block text-align="right"><fo:inline text-align="right" color="#000000" font="5pt ARIAL"><fo:page-number/></fo:inline></fo:block>
		</fo:static-content>
		<fo:flow flow-name="xsl-region-body">
			<!--Header Image-->
			<fo:block-container span="all" width="890px" background-image="url('Images\GuideCoverTopBar.gif')" height="47px" background-repeat="no-repeat" display-align="center" >
				<fo:block margin-left="250px">
					<fo:table>
						<fo:table-body>
							<fo:table-row>
								<fo:table-cell width="500px">
									<fo:block  font="14pt ARIAL" color="#FFFFFF">
										<xsl:apply-templates select="../cover/content[@name='subscriptionType']/text()"></xsl:apply-templates> Guide, <xsl:apply-templates select="../cover/content[@name='subscriptionDate']/text()"></xsl:apply-templates>
									</fo:block>
								</fo:table-cell>
								<fo:table-cell>
									<fo:block font="7pt ARIAL" color="#FFFFFF">Volume 
										<xsl:apply-templates select="../cover/content[@name='volume']/text()"></xsl:apply-templates>, Issue<xsl:apply-templates select="cover/content[@name='number']/text()"></xsl:apply-templates>
									</fo:block>
								</fo:table-cell>
							</fo:table-row>
						</fo:table-body>
					</fo:table>
				</fo:block>
			</fo:block-container>
			<!--Subscriber Details-->
			<fo:block span="all">
				<fo:table>
					<fo:table-body>
						<fo:table-row>
							<fo:table-cell width="660px">
								<fo:block font="9pt ARIAL" color=" #000000"><xsl:apply-templates select="../cover/content[@name='name']/text()"></xsl:apply-templates>,<xsl:apply-templates select="../cover/content[@name='company']/text()"></xsl:apply-templates>,<xsl:apply-templates select="../cover/content[@name='city']/text()"></xsl:apply-templates>,<xsl:apply-templates select="../cover/content[@name='state']/text()"></xsl:apply-templates></fo:block>
							</fo:table-cell>
							<fo:table-cell>
								<fo:block>
									<fo:table font="7pt ARIAL #666666">
										<fo:table-column column-width="140px"/>
										<fo:table-column column-width="120px"/>
										<fo:table-body>
											<fo:table-row>
												<fo:table-cell>
													<fo:block font="7pt ARIAL" color="#000000">Onvia Account Executive:</fo:block>
												</fo:table-cell>
												<fo:table-cell>
													<fo:block font="7pt ARIAL" color="#0033CC" text-decoration="underline">
														<xsl:apply-templates select="../cover/content[@name='onviaAccountExecutive']/text()"></xsl:apply-templates>
													</fo:block>
												</fo:table-cell>
											</fo:table-row>
											<fo:table-row>
												<fo:table-cell>
													<fo:block font="7pt ARIAL" color="#000000">Phone:</fo:block>
												</fo:table-cell>
												<fo:table-cell>
													<fo:block>
														<xsl:apply-templates select="../cover/content[@name='phone']/text()"></xsl:apply-templates>
													</fo:block>
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
			<!--Subscriber Footer-->
			<fo:block span="all">
				<fo:external-graphic content-width="890px" src="url('Images\GreyHorizontalBar.gif')"/>
			</fo:block>
			<!--Saved Search title-->
			<fo:block span="all" font="7pt ARIAL" margin-left="8px" margin-top="8px" color="#666666">Saved Search 1</fo:block>
			<fo:block span="all" font="14pt ARIAL" margin-left="8px" margin-top="8px" color="#000000"><xsl:apply-templates select="content[@name='savedSearchName']/text()"></xsl:apply-templates>
			</fo:block>
			<fo:block span="all" alignment-baseline="central">
				<fo:leader leader-length="890px" leader-pattern="rule" alignment-baseline="top" leader-pattern-width="4px" color="#cccccc"/>
			</fo:block>
			<fo:block span="all" margin-left="8px" margin-right="8px">
				<fo:table>
					<fo:table-body>
						<fo:table-row>
							<fo:table-cell width="420px">
								<fo:block>
									<fo:table>
										<fo:table-column column-width="108px"/>
										<fo:table-column/>
										<fo:table-body>
											<fo:table-row height="13px">
												<fo:table-cell>
													<fo:block font="7pt ARIAL" color="#666666">Type</fo:block>
												</fo:table-cell>
												<fo:table-cell>
													<fo:block font="9 PT ARIAL" color="#000000"><xsl:apply-templates select="content[@name='type']/text()"></xsl:apply-templates>
													</fo:block>
												</fo:table-cell>
											</fo:table-row>
											<fo:table-row height="13px">
												<fo:table-cell>
													<fo:block font="7pt ARIAL" color="#666666">Project Name</fo:block>
												</fo:table-cell>
												<fo:table-cell >
													<fo:block>
														<fo:basic-link font="12pt ARIAL" color="#0033CC" text-decoration="underline" external-destination="url('http://www.google.com/')"><xsl:apply-templates select="content[@name='projectName']/text()"></xsl:apply-templates></fo:basic-link>
													</fo:block>
												</fo:table-cell>
											</fo:table-row>
											<fo:table-row height="13px">
												<fo:table-cell>
													<fo:block font="7pt ARIAL" color="#666666">Submittal Date</fo:block>
												</fo:table-cell>
												<fo:table-cell>
													<fo:block font="9 PT ARIAL" color="#000000">
														<xsl:apply-templates select="content[@name='submittalDate']/text()"></xsl:apply-templates>
													</fo:block>
												</fo:table-cell>
											</fo:table-row>
										</fo:table-body>
									</fo:table>
								</fo:block>
							</fo:table-cell>
							<fo:table-cell padding-left="30px">
								<fo:block >
									<fo:external-graphic content-width="135px" src="url('Images\ResearchOnlline.gif')"/>
									<fo:external-graphic content-width="135px" src="url('Images\PlanHolderList.gif')"/>
									<fo:external-graphic content-width="135px" src="url('Images\BiddersList.gif')"/>
								</fo:block>
							</fo:table-cell>
						</fo:table-row>
					</fo:table-body>
				</fo:table>
			</fo:block>
			<fo:block span="all" alignment-baseline="central">
				<fo:leader leader-length="890px" leader-pattern="rule" alignment-baseline="top" leader-pattern-width="2px" color="#CCCCCC"/>
			</fo:block>
			<!--Project details-->
			<fo:block span="all" margin-left="8px" margin-right="8px">
				<fo:table>
					<fo:table-body>
						<fo:table-row>
							<fo:table-cell width="420px">
								<fo:block>
									<fo:table>
									<fo:table-column column-width="108px"/>
									<fo:table-column/>
									<fo:table-body>
										<fo:table-row height="13px">
											<fo:table-cell>
												<fo:block font="7pt ARIAL" color="#666666">Owner</fo:block>
											</fo:table-cell>
											<fo:table-cell>
												<fo:block font="9pt ARIAL" color="#000000">
													<xsl:apply-templates select="content[@name='owner']/text()"></xsl:apply-templates>
													</fo:block>
												<fo:block font="7pt ARIAL" color="#0033CC">
													[ 
													<fo:basic-link  text-decoration="underline" external-destination="url('http://www.google.com/')">Owner Procurement History</fo:basic-link>
													 ]
												</fo:block>
											</fo:table-cell>							
										</fo:table-row>
										<fo:table-row height="13px">
											<fo:table-cell>
												<fo:block font="7pt ARIAL" color="#666666">Owner website</fo:block>
											</fo:table-cell>
											<fo:table-cell>
												<fo:block font="9pt ARIAL" color="#0033CC">
													<fo:basic-link  text-decoration="underline" external-destination="url('http://www.usva.gov/')"><xsl:apply-templates select="content[@name='ownerWebsite']/text()"></xsl:apply-templates></fo:basic-link>
												</fo:block>
											</fo:table-cell>
										</fo:table-row>
										<fo:table-row height="13px">
											<fo:table-cell>
												<fo:block font="7pt ARIAL" color="#666666">Location</fo:block>
											</fo:table-cell>
											<fo:table-cell>
												<fo:block font="9pt ARIAL" color="#000000">
													<xsl:apply-templates select="content[@name='locationCity']/text()"></xsl:apply-templates>, <xsl:apply-templates select="content[@name='locationState']/text()"></xsl:apply-templates>
												</fo:block>
											</fo:table-cell>
										</fo:table-row>
										<fo:table-row height="13px">
											<fo:table-cell>
												<fo:block font="7pt ARIAL" color="#666666">Zip Code</fo:block>
											</fo:table-cell>
											<fo:table-cell>
												<fo:block font="9pt ARIAL" color="#000000"><xsl:apply-templates select="content[@name='zipCode']/text()"></xsl:apply-templates>
												</fo:block>
											</fo:table-cell>
										</fo:table-row>
										<fo:table-row height="13px">
											<fo:table-cell>
												<fo:block font="7pt ARIAL" color="#666666">County</fo:block>
											</fo:table-cell>
											<fo:table-cell>
												<fo:block font="9pt ARIAL" color="#000000"><xsl:apply-templates select="content[@name='country']/text()"></xsl:apply-templates>
												</fo:block>
											</fo:table-cell>
										</fo:table-row>
										<fo:table-row height="13px">
											<fo:table-cell>
												<fo:block font="7pt ARIAL" color="#666666">Value</fo:block>
											</fo:table-cell>
											<fo:table-cell>
												<fo:block font="9pt ARIAL" color="#000000"><xsl:apply-templates select="content[@name='value']/text()"></xsl:apply-templates>
												</fo:block>
											</fo:table-cell>
										</fo:table-row>
										<fo:table-row height="13px">
												<fo:table-cell>
													<fo:block/>
												</fo:table-cell>
												<fo:table-cell>
													<fo:block/>
												</fo:table-cell>
											</fo:table-row>
										<fo:table-row height="13px">
											<fo:table-cell>
												<fo:block font="7pt ARIAL" color="#666666">Market Sector</fo:block>
											</fo:table-cell>
											<fo:table-cell>
												<fo:block font="9pt ARIAL" color="#000000"><xsl:apply-templates select="content[@name='marketSector']/text()"></xsl:apply-templates>
												</fo:block>
											</fo:table-cell>
										</fo:table-row>
										<fo:table-row height="13px">
											<fo:table-cell>
												<fo:block font="7pt ARIAL" color="#666666">Buyer</fo:block>
											</fo:table-cell>
											<fo:table-cell>
												<fo:block font="9pt ARIAL" color="#0033CC">
													<fo:basic-link  text-decoration="underline" external-destination="url('mailto:Lorna.Craig@test.com')"><xsl:apply-templates select="content[@name='buyer']/text()"></xsl:apply-templates></fo:basic-link>
													<fo:inline color="#000000">, <xsl:apply-templates select="content[@name='buyerRole']/text()"></xsl:apply-templates></fo:inline>
												</fo:block>
												<fo:block font="7pt ARIAL" color="#0033CC">
													[ 
													<fo:basic-link  text-decoration="underline" external-destination="url('http://www.google.com/')">Buyer Procurement History</fo:basic-link>
													 ]
												</fo:block>
											</fo:table-cell>
										</fo:table-row>
										<fo:table-row height="13px">
											<fo:table-cell>
												<fo:block font="7pt ARIAL" color="#666666">Buyer Phone</fo:block>
											</fo:table-cell>
											<fo:table-cell>
												<fo:block font="9pt ARIAL" color="#000000"><xsl:apply-templates select="content[@name='buyerPhone']/text()"></xsl:apply-templates></fo:block>
											</fo:table-cell>
										</fo:table-row>
										<fo:table-row height="13px">
												<fo:table-cell>
													<fo:block/>
												</fo:table-cell>
												<fo:table-cell>
													<fo:block/>
												</fo:table-cell>
											</fo:table-row>
										<fo:table-row height="13px">
											<fo:table-cell>
												<fo:block font="7pt ARIAL" color="#666666">Onvia Ref Number</fo:block>
											</fo:table-cell>
											<fo:table-cell>
												<fo:block font="9pt ARIAL" color="#000000"><xsl:apply-templates select="content[@name='onviaReferenceNumber']/text()"></xsl:apply-templates></fo:block>
											</fo:table-cell>
										</fo:table-row>
										<fo:table-row height="13px">
											<fo:table-cell>
												<fo:block font="7pt ARIAL" color="#666666">Project Number</fo:block>
											</fo:table-cell>
											<fo:table-cell>
												<fo:block font="9pt ARIAL" color="#000000"><xsl:apply-templates select="content[@name='projectNumber']/text()"></xsl:apply-templates></fo:block>
											</fo:table-cell>
										</fo:table-row>
										<fo:table-row height="13px" display-align="after">
											<fo:table-cell >
												<fo:block font="7pt ARIAL" color="#666666">Documents</fo:block>
											</fo:table-cell>
											<fo:table-cell >
												<fo:block>
													<fo:external-graphic src="url('Images\Amendment.gif')"/>
													<fo:basic-link font="9pt ARIAL" color="#0033CC"  text-decoration="underline" external-destination="url('http://www.google.com/')"><xsl:apply-templates select="content[@name='Documents']/text()"></xsl:apply-templates></fo:basic-link>
													<fo:inline font="7pt ARIAL" margin-left="50px" color="#000000">Added <xsl:apply-templates select="content[@name='documentAddedOn']/text()"></xsl:apply-templates></fo:inline>
												</fo:block>
											</fo:table-cell>
										</fo:table-row>
									</fo:table-body>
								</fo:table>
								</fo:block>
							</fo:table-cell>
							<fo:table-cell padding-left="30px">
								<fo:block>
									<fo:external-graphic content-width="267px" border="3px solid #cccccc" src="url('Images\GoogleMap.gif')"/>
								</fo:block>
								<fo:block font="8pt ARIAL" color="#0033CC" vertical-align="middle">
									<fo:external-graphic content-width="30px" src="url('Images\print.gif')"/>
									<fo:basic-link text-decoration="underline" external-destination="url('http://www.google.com/')">Print This</fo:basic-link>
									<fo:external-graphic content-width="30px" src="url('Images\email.gif')"/>
									<fo:basic-link text-decoration="underline" external-destination="url('http://www.google.com/')">Send This</fo:basic-link>
									<fo:external-graphic content-width="30px" src="url('Images\rate.gif')"/>
									<fo:basic-link text-decoration="underline" external-destination="url('http://www.google.com/')">Rate This</fo:basic-link>
								</fo:block>
							</fo:table-cell>
						</fo:table-row>
					</fo:table-body>
				</fo:table>				
			</fo:block>
			<fo:block span="all" alignment-baseline="central">
				<fo:leader leader-length="890px" leader-pattern="rule" alignment-baseline="top" leader-pattern-width="2px" color="#CCCCCC"/>
			</fo:block>
			<!--Project description-->
			<fo:block margin-left="8px" margin-right="8px" font="9pt ARIAL"><xsl:apply-templates select="content[@name='projectDescription']/text()"></xsl:apply-templates>			</fo:block>
		</fo:flow>
	</fo:page-sequence>
			</xsl:when>
			<xsl:when test="content[@name='type']/text() ='Pre Planning'">
				<!--Project Details(Pre-Planning)-->
	<fo:page-sequence master-reference="PagingAll" format="1">
		<fo:static-content flow-name="xsl-region-after" width="100%">
			<fo:block margin-left="8px" margin-right="8px" font="5pt ARIAL" color="#666666">The Onvia Guide © 2008 Onvia, Inc. All rights are reserved. Unless you have a multiple site or multiple office license with Onvia, only you alone can use The Onvia Guide at asingle location. Without the written consent of Onvia, you cannot modify, copy, display, reproduce, share, sell, publish, transfer, assign, or distribute The Onvia Guide or anyportion thereof. For any questions regarding licenses to your other office locations, please contact Onvia Customer Service at (888)484-3374 or customerservice@onvia.com</fo:block>
			<fo:block text-align="right"><fo:inline text-align="right" color="#000000" font="5pt ARIAL"><fo:page-number/></fo:inline></fo:block>
		</fo:static-content>
		<fo:flow flow-name="xsl-region-body">
			<!--Header Image-->
			<fo:block-container span="all" width="890px" background-image="url('Images\GuideCoverTopBar.gif')" height="47px" background-repeat="no-repeat" display-align="center" >
				<fo:block margin-left="250px">
					<fo:table>
						<fo:table-body>
							<fo:table-row>
								<fo:table-cell width="500px">
									<fo:block  font="14pt ARIAL" color="#FFFFFF"><xsl:apply-templates select="../cover/content[@name='subscriptionType']/text()"></xsl:apply-templates> Guide, <xsl:apply-templates select="../cover/content[@name='subscriptionDate']/text()"></xsl:apply-templates></fo:block>
								</fo:table-cell>
								<fo:table-cell>
									<fo:block font="7pt ARIAL" color="#FFFFFF"><xsl:apply-templates select="../cover/content[@name='volume']/text()"></xsl:apply-templates>, Issue<xsl:apply-templates select="cover/content[@name='number']/text()"></xsl:apply-templates></fo:block>
								</fo:table-cell>
							</fo:table-row>
						</fo:table-body>
					</fo:table>
				</fo:block>
			</fo:block-container>
			<!--Subscriber Details-->
			<fo:block span="all">
				<fo:table>
					<fo:table-body>
						<fo:table-row>
							<fo:table-cell width="660px">
								<fo:block font="9pt ARIAL" color=" #000000"><xsl:apply-templates select="../cover/content[@name='name']/text()"></xsl:apply-templates>,<xsl:apply-templates select="../cover/content[@name='company']/text()"></xsl:apply-templates>,<xsl:apply-templates select="../cover/content[@name='city']/text()"></xsl:apply-templates>,<xsl:apply-templates select="../cover/content[@name='state']/text()"></xsl:apply-templates></fo:block>
							</fo:table-cell>
							<fo:table-cell>
								<fo:block>
									<fo:table font="7pt ARIAL #666666">
										<fo:table-column column-width="140px"/>
										<fo:table-column column-width="120px"/>
										<fo:table-body>
											<fo:table-row>
												<fo:table-cell>
													<fo:block font="7pt ARIAL" color="#000000">Onvia Account Executive:</fo:block>
												</fo:table-cell>
												<fo:table-cell>
													<fo:block font="7pt ARIAL" color="#0033CC" text-decoration="underline"><xsl:apply-templates select="../cover/content[@name='onviaAccountExecutive']/text()"></xsl:apply-templates></fo:block>
												</fo:table-cell>
											</fo:table-row>
											<fo:table-row>
												<fo:table-cell>
													<fo:block font="7pt ARIAL" color="#000000">Phone:</fo:block>
												</fo:table-cell>
												<fo:table-cell>
													<fo:block><xsl:apply-templates select="../cover/content[@name='phone']/text()"></xsl:apply-templates></fo:block>
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
			<!--Subscriber Footer-->
			<fo:block span="all">
				<fo:external-graphic content-width="890px" src="url('Images\GreyHorizontalBar.gif')"/>
			</fo:block>
			<!--Saved Search Title-->
			<fo:block alignment-baseline="central" margin-left="5px" margin-right="5px" span="all">
				<fo:table width="480px">
					<fo:table-body>
						<fo:table-row height="11px" margin-top="7px">
							<fo:table-cell><fo:block  font="7pt ARIAL" color="#666666">Saved Search 2</fo:block></fo:table-cell>
						</fo:table-row>
						<fo:table-row height="19px">
							<fo:table-cell number-columns-spanned="2">
								<fo:block font="14pt ARIAL" color="#000000" text-align="left"><xsl:apply-templates select="content[@name='savedSearchName']/text()"></xsl:apply-templates></fo:block>
							</fo:table-cell>
						</fo:table-row>
					</fo:table-body>
				</fo:table>
			</fo:block>
			
			<!--line break-->
			<fo:block alignment-baseline="central" span="all">
				<fo:leader leader-length="100%" leader-pattern="rule" alignment-baseline="middle" rule-thickness="1px" color="#CCCCCC"/>
			</fo:block>			
			<!--Project title-->
			<fo:block span="all" margin-left="8px" margin-right="8px">
				<fo:table>
					<fo:table-body>
						<fo:table-row>
							<fo:table-cell width="420px">
								<fo:block>
									<fo:table>
										<fo:table-column column-width="108px"/>
										<fo:table-column/>
										<fo:table-body>
											<fo:table-row height="13px">
												<fo:table-cell>
													<fo:block font="7pt ARIAL" color="#666666">Type</fo:block>
												</fo:table-cell>
												<fo:table-cell>
													<fo:block font="9 PT ARIAL" color="#000000"><xsl:apply-templates select="content[@name='type']/text()"></xsl:apply-templates>
													</fo:block>
												</fo:table-cell>
											</fo:table-row>
											<fo:table-row height="13px">
												<fo:table-cell>
													<fo:block font="7pt ARIAL" color="#666666">Project Name</fo:block>
												</fo:table-cell>
												<fo:table-cell >
													<fo:block>
														<fo:basic-link font="12pt ARIAL" color="#0033CC" text-decoration="underline" external-destination="url('http://www.google.com/')"><xsl:apply-templates select="content[@name='projectName']/text()"></xsl:apply-templates></fo:basic-link>
													</fo:block>
												</fo:table-cell>
											</fo:table-row>
										</fo:table-body>
									</fo:table>
								</fo:block>
							</fo:table-cell>
							<fo:table-cell padding-left="30px">
								<fo:block >
									<fo:external-graphic content-width="135px" src="url('Images\ResearchOnlline.gif')"/>
								</fo:block>
							</fo:table-cell>
						</fo:table-row>
					</fo:table-body>
				</fo:table>
			</fo:block>
			
			<!--Line Break-->
			<fo:block span="all">
				<fo:leader leader-length="100%" leader-pattern="rule" alignment-baseline="middle" rule-thickness="1px" color="#CCCCCC"/>
			</fo:block>
			
			<!--Project details-->
			<fo:block span="all" margin-left="8px" margin-right="8px">
				<fo:table>
					<fo:table-body>
						<fo:table-row>
							<fo:table-cell width="420px">
								<fo:block>
									<fo:table>
										<fo:table-column column-width="108px"/>
										<fo:table-column/>
										<fo:table-body>
											<fo:table-row height="13px">
												<fo:table-cell>
													<fo:block font="7pt ARIAL" color="#666666">Location:</fo:block>
												</fo:table-cell>
												<fo:table-cell>
													<fo:block font="9pt ARIAL" color="#000000"><xsl:apply-templates select="content[@name='location']/text()"></xsl:apply-templates></fo:block>
												</fo:table-cell>							
											</fo:table-row>
											<fo:table-row height="13px">
												<fo:table-cell>
													<fo:block font="7pt ARIAL" color="#666666">Publication Date:</fo:block>
												</fo:table-cell>
												<fo:table-cell>
													<fo:block font="9pt ARIAL" color="#000000"><xsl:apply-templates select="content[@name='publicationDate']/text()"></xsl:apply-templates></fo:block>
												</fo:table-cell>							
											</fo:table-row>
											<fo:table-row height="35px">
												<fo:table-cell>
													<fo:block font="7pt ARIAL" color="#666666">Meeting Date:</fo:block>
												</fo:table-cell>
												<fo:table-cell>
													<fo:block font="9pt ARIAL" color="#000000"><xsl:apply-templates select="content[@name='meetingDate']/text()"></xsl:apply-templates></fo:block>
												</fo:table-cell>							
											</fo:table-row>
											<fo:table-row height="13px">
												<fo:table-cell>
													<fo:block font="7pt ARIAL" color="#666666">Development Type:</fo:block>
												</fo:table-cell>
												<fo:table-cell>
													<fo:block font="9pt ARIAL" color="#000000"><xsl:apply-templates select="content[@name='developmentType']/text()"></xsl:apply-templates></fo:block>
												</fo:table-cell>							
											</fo:table-row>
											<fo:table-row height="13px">
												<fo:table-cell>
													<fo:block font="7pt ARIAL" color="#666666">Proposed Product:</fo:block>
												</fo:table-cell>
												<fo:table-cell>
													<fo:block font="9pt ARIAL" color="#000000"><xsl:apply-templates select="content[@name='proposedProduct']/text()"></xsl:apply-templates></fo:block>
												</fo:table-cell>							
											</fo:table-row>
											<fo:table-row height="13px">
												<fo:table-cell>
													<fo:block font="7pt ARIAL" color="#666666">Entitlement Status:</fo:block>
												</fo:table-cell>
												<fo:table-cell>
													<fo:block font="9pt ARIAL" color="#000000"><xsl:apply-templates select="content[@name='entitlementStatus']/text()"></xsl:apply-templates></fo:block>
												</fo:table-cell>							
											</fo:table-row>
											<fo:table-row height="13px">
												<fo:table-cell>
													<fo:block font="7pt ARIAL" color="#666666">Project Address:</fo:block>
												</fo:table-cell>
												<fo:table-cell>
													<fo:block font="9pt ARIAL" color="#000000"><xsl:apply-templates select="content[@name='projectAddress']/text()"></xsl:apply-templates></fo:block>
												</fo:table-cell>							
											</fo:table-row>
											<fo:table-row height="13px">
												<fo:table-cell>
													<fo:block/>
												</fo:table-cell>
												<fo:table-cell>
													<fo:block/>
												</fo:table-cell>
											</fo:table-row>
											<fo:table-row height="13px">
												<fo:table-cell>
													<fo:block font="7pt ARIAL" color="#666666">Zoning Change:</fo:block>
												</fo:table-cell>
												<fo:table-cell>
													<fo:block font="9pt ARIAL" color="#000000"><xsl:apply-templates select="content[@name='zoningChange']/text()"></xsl:apply-templates></fo:block>
												</fo:table-cell>							
											</fo:table-row>
											<fo:table-row height="13px">
												<fo:table-cell>
													<fo:block font="7pt ARIAL" color="#666666">Notes:</fo:block>
												</fo:table-cell>
												<fo:table-cell>
													<fo:block font="9pt ARIAL" color="#000000"><xsl:apply-templates select="content[@name='notes']/text()"></xsl:apply-templates></fo:block>
												</fo:table-cell>							
											</fo:table-row>
											<fo:table-row height="13px">
												<fo:table-cell>
													<fo:block/>
												</fo:table-cell>
												<fo:table-cell>
													<fo:block/>
												</fo:table-cell>
											</fo:table-row>
											<fo:table-row height="13px">
												<fo:table-cell>
													<fo:block font="7pt ARIAL" color="#666666">Contact</fo:block>
												</fo:table-cell>
												<fo:table-cell>
													<fo:block font="9pt ARIAL" color="#000000"><xsl:apply-templates select="content[@name='contacts']/text()"></xsl:apply-templates></fo:block>
												</fo:table-cell>							
											</fo:table-row>
											<fo:table-row height="13px">
												<fo:table-cell>
													<fo:block font="7pt ARIAL" color="#666666">Address:</fo:block>
												</fo:table-cell>
												<fo:table-cell>
													<fo:block font="9pt ARIAL" color="#000000">70 East Horizon Ridge Parkway,Suite 190, Henderson,NV,89002</fo:block>
												</fo:table-cell>							
											</fo:table-row>
											<fo:table-row height="13px">
												<fo:table-cell>
													<fo:block/>
												</fo:table-cell>
												<fo:table-cell>
													<fo:block/>
												</fo:table-cell>
											</fo:table-row>
											<fo:table-row height="13px">
												<fo:table-cell>
													<fo:block font="7pt ARIAL" color="#666666">Name:</fo:block>
												</fo:table-cell>
												<fo:table-cell>
													<fo:block font="9pt ARIAL" color="#000000">Paulette Stacy</fo:block>
												</fo:table-cell>							
											</fo:table-row>
											<fo:table-row height="13px">
												<fo:table-cell>
													<fo:block font="7pt ARIAL" color="#666666">Contact:</fo:block>
												</fo:table-cell>
												<fo:table-cell>
													<fo:block font="9pt ARIAL" color="#000000">Steptoe Garden Co., Lp</fo:block>
												</fo:table-cell>							
											</fo:table-row>
											<fo:table-row height="13px">
												<fo:table-cell>
													<fo:block font="7pt ARIAL" color="#666666">Role:</fo:block>
												</fo:table-cell>
												<fo:table-cell>
													<fo:block font="9pt ARIAL" color="#000000">Applicant, Owner</fo:block>
												</fo:table-cell>							
											</fo:table-row>
											<fo:table-row height="13px">
												<fo:table-cell>
													<fo:block font="7pt ARIAL" color="#666666">Address:</fo:block>
												</fo:table-cell>
												<fo:table-cell>
													<fo:block font="9pt ARIAL" color="#000000">5070 Tara Ave,#116,Las Vegas,NV,89146</fo:block>
												</fo:table-cell>							
											</fo:table-row>
											<fo:table-row height="13px">
												<fo:table-cell>
													<fo:block font="7pt ARIAL" color="#666666">Name:</fo:block>
												</fo:table-cell>
												<fo:table-cell>
													<fo:block font="9pt ARIAL" color="#000000">Steven Grandview</fo:block>
												</fo:table-cell>							
											</fo:table-row>
											<fo:table-row height="13px">
												<fo:table-cell>
													<fo:block font="7pt ARIAL" color="#666666">Title:</fo:block>
												</fo:table-cell>
												<fo:table-cell>
													<fo:block font="9pt ARIAL" color="#000000">Vice President</fo:block>
												</fo:table-cell>							
											</fo:table-row>
											<fo:table-row height="13px">
												<fo:table-cell>
													<fo:block font="7pt ARIAL" color="#666666">Department:</fo:block>
												</fo:table-cell>
												<fo:table-cell>
													<fo:block font="9pt ARIAL" color="#000000">Engineering</fo:block>
												</fo:table-cell>							
											</fo:table-row>
											<fo:table-row height="13px">
												<fo:table-cell>
													<fo:block font="7pt ARIAL" color="#666666">Phone:</fo:block>
												</fo:table-cell>
												<fo:table-cell>
													<fo:block font="9pt ARIAL" color="#000000">(589) 555-5678</fo:block>
												</fo:table-cell>							
											</fo:table-row>
											<fo:table-row height="13px">
												<fo:table-cell>
													<fo:block font="7pt ARIAL" color="#666666">Fax:</fo:block>
												</fo:table-cell>
												<fo:table-cell>
													<fo:block font="9pt ARIAL" color="#000000">(589) 555-5600</fo:block>
												</fo:table-cell>							
											</fo:table-row>
											<fo:table-row height="13px">
												<fo:table-cell>
													<fo:block font="7pt ARIAL" color="#666666">Email:</fo:block>
												</fo:table-cell>
												<fo:table-cell>
													<fo:block font="9pt ARIAL" color="#0033CC">
														<fo:basic-link  text-decoration="underline" external-destination="url('mailto:Steven.Grandview@Steptoe.com')">Steven.Grandview@Steptoe.com</fo:basic-link>
													</fo:block>
												</fo:table-cell>							
											</fo:table-row>
											<fo:table-row height="13px">
												<fo:table-cell>
													<fo:block/>
												</fo:table-cell>
												<fo:table-cell>
													<fo:block/>
												</fo:table-cell>
											</fo:table-row>
											<fo:table-row height="13px">
												<fo:table-cell>
													<fo:block font="7pt ARIAL" color="#666666">Planning Officials:</fo:block>
												</fo:table-cell>
												<fo:table-cell>
													<fo:block font="9pt ARIAL" color="#000000"><xsl:apply-templates select="content[@name='planningOfficials']/text()"></xsl:apply-templates></fo:block>
												</fo:table-cell>							
											</fo:table-row>
											<fo:table-row height="13px">
												<fo:table-cell>
													<fo:block font="7pt ARIAL" color="#666666">Address:</fo:block>
												</fo:table-cell>
												<fo:table-cell>
													<fo:block font="9pt ARIAL" color="#000000"><xsl:apply-templates select="content[@name='planningOfficialsAddress']/text()"></xsl:apply-templates></fo:block>
												</fo:table-cell>							
											</fo:table-row>
											<fo:table-row height="13px">
												<fo:table-cell>
													<fo:block font="7pt ARIAL" color="#666666">Website:</fo:block>
												</fo:table-cell>
												<fo:table-cell>
													<fo:block font="9pt ARIAL" color="#0033CC">
														<fo:basic-link  text-decoration="underline" external-destination="url('http://dsnet.co.clark.nv.us/')"><xsl:apply-templates select="content[@name='planningOfficialsWebsite']/text()"></xsl:apply-templates></fo:basic-link>
													</fo:block>
													<fo:block font="7pt ARIAL" color="#0033CC">
														[ 
														<fo:basic-link  text-decoration="underline" external-destination="url('http://www.google.com/')">Planning Official Contacts</fo:basic-link>
														 ]
													</fo:block>
												</fo:table-cell>							
											</fo:table-row>
											<fo:table-row height="13px">
												<fo:table-cell>
													<fo:block/>
												</fo:table-cell>
												<fo:table-cell>
													<fo:block/>
												</fo:table-cell>
											</fo:table-row>
											<fo:table-row height="13px">
												<fo:table-cell>
													<fo:block font="7pt ARIAL" color="#666666">Project File #:</fo:block>
												</fo:table-cell>
												<fo:table-cell>
													<fo:block font="9pt ARIAL" color="#000000"><xsl:apply-templates select="content[@name='projectFile#']/text()"></xsl:apply-templates></fo:block>
												</fo:table-cell>							
											</fo:table-row>
											<fo:table-row height="13px">
												<fo:table-cell>
													<fo:block font="7pt ARIAL" color="#666666">APN #:</fo:block>
												</fo:table-cell>
												<fo:table-cell>
													<fo:block font="9pt ARIAL" color="#000000"><xsl:apply-templates select="content[@name='APN#']/text()"></xsl:apply-templates></fo:block>
												</fo:table-cell>							
											</fo:table-row>
											<fo:table-row height="13px">
												<fo:table-cell>
													<fo:block font="7pt ARIAL" color="#666666">Onvia Number:</fo:block>
												</fo:table-cell>
												<fo:table-cell>
													<fo:block font="9pt ARIAL" color="#000000"><xsl:apply-templates select="content[@name='onviaNumber']/text()"></xsl:apply-templates></fo:block>
												</fo:table-cell>							
											</fo:table-row>
											<fo:table-row height="13px" display-align="after">
												<fo:table-cell >
													<fo:block font="7pt ARIAL" color="#666666">Documents</fo:block>
												</fo:table-cell>
												<fo:table-cell >
													<fo:block>
														<fo:external-graphic src="url('Images\Amendment.gif')"/>
														<fo:basic-link font="9pt ARIAL" color="#0033CC" text-decoration="underline" external-destination="url('http://www.google.com/')"><xsl:apply-templates select="content[@name='Documents']/text()"></xsl:apply-templates></fo:basic-link>
														<fo:inline font="7pt ARIAL" margin-left="50px" color="#0033CC" white-space-collapse="false">Added 9/2/2008</fo:inline>
													</fo:block>
												</fo:table-cell>
											</fo:table-row>
										</fo:table-body>
									</fo:table>
								</fo:block>
							</fo:table-cell>
							<fo:table-cell padding-left="30px">
								<fo:block>
									<fo:external-graphic content-width="267px" border="3px solid #cccccc" src="url('Images\GoogleMap.gif')"/>
								</fo:block>
								<fo:block font="8pt ARIAL" color="#0033CC" vertical-align="middle">
									<fo:external-graphic content-width="30px" src="url('Images\print.gif')"/>
									<fo:basic-link text-decoration="underline" external-destination="url('http://www.google.com/')">Print This</fo:basic-link>
									<fo:external-graphic content-width="30px" src="url('Images\email.gif')"/>
									<fo:basic-link text-decoration="underline" external-destination="url('http://www.google.com/')">Send This</fo:basic-link>
									<fo:external-graphic content-width="30px" src="url('Images\rate.gif')"/>
									<fo:basic-link text-decoration="underline" external-destination="url('http://www.google.com/')">Rate This</fo:basic-link>
								</fo:block>
							</fo:table-cell>
						</fo:table-row>
					</fo:table-body>
				</fo:table>
			</fo:block>
			<fo:block span="all" alignment-baseline="central">
				<fo:leader leader-length="890px" leader-pattern="rule" alignment-baseline="top" leader-pattern-width="2px" color="#CCCCCC"/>
			</fo:block>
			<!--Project description-->
			<fo:block margin-left="8px" margin-right="8px" font="9pt ARIAL"><xsl:apply-templates select="content[@name='projectDescription']/text()"></xsl:apply-templates></fo:block>
		</fo:flow>
	</fo:page-sequence>
			</xsl:when>
		</xsl:choose>
	</xsl:for-each>
  </fo:root>
</xsl:template>
</xsl:stylesheet>
