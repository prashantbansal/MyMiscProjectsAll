<?xml version='1.0' encoding='ISO-8859-1'?>

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:fo="http://www.w3.org/1999/XSL/Format" xmlns:rx="http://www.renderx.com/XSL/Extensions" version="1.0">

<xsl:output method="xml" version="1.0" encoding="ISO-8859-1"/>

<xsl:strip-space elements="*"/>

  <xsl:template match="widgetpile">
    <xsl:for-each select="widgets">
      Number of Widgets in this group: <xsl:value-of select="count(widget)"/>
    </xsl:for-each>
    <xsl:apply-templates/>
  </xsl:template>


</xsl:stylesheet>
