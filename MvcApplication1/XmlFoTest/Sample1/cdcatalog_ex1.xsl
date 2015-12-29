<?xml version="1.0" encoding="ISO-8859-1"?>
<!-- Edited by XMLSpy� -->
<xsl:stylesheet version="1.0"
xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:template match="/">
<xsl:apply-templates/>
  <html>
  <body>
    <h2>My CD Collection</h2>
    <table border="1">
      <tr bgcolor="#9acd32">
        <th>Title</th>
        <th>Artist</th>
        <th>IfCondtion</th>
      </tr>
      <xsl:for-each select="catalog/cd[artist!='Bob Dylan']">
      <xsl:sort order="descending" select="price"/>
      <tr>
        <td><xsl:value-of select="title"/></td>
        <td>hello</td>
        <td>
        <xsl:choose>
							
			<xsl:when test="price &gt; 10">
			abc
			</xsl:when>
			<xsl:otherwise> cde
			</xsl:otherwise>
											</xsl:choose>
        </td>
      </tr>
      </xsl:for-each>
    </table>
  </body>
  </html>
</xsl:template>
</xsl:stylesheet>