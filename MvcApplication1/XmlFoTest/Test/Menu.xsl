<?xml version="1.0" encoding="iso-8859-1"?> 
<xsl:stylesheet version="1.0"
 xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:asp="http://www.microsoft.com"> 
<xsl:output method="html" indent="yes" encoding="iso-8859-1"/> 
<xsl:template match="MenuItems/*">
<xsl:variable name="NodeName">
<xsl:value-of select="name(current())"/>
</xsl:variable>
<html>
<head>
<script lang="javascript" type="text/javascript" >
 function HideShowDiv(divid)
 {
      var divlayer = document.getElementById(divid);
      if(divlayer.style.display == "block")
      {
      divlayer.style.display = "none";
      }
      else
      divlayer.style.display = "block"
 }
  function ChangeBg(tdid)
  {
  var td = document.getElementById(tdid);
  td.style.background = "#3399ff";
  td.style.color= "white";
  }
  function ReturnBg(tdid)
  {
  var td = document.getElementById(tdid);
  td.style.background = "white";
  td.style.color = "black";
  }
  </script>
</head>
<body>
<table border="1" width="150px" >
<tr>
<td onmousedown="HideShowDiv('{$NodeName}')" align="Center"><xsl:value-of select="$NodeName"/></td>
</tr>
</table>
<div style="OVERFLOW:AUTO; width=150px;height=100px; display:none" runat="server" id="{$NodeName}" >
<xsl:for-each select="node()">
<table>
<xsl:variable name="ChildNodeName">
<xsl:value-of select="./child::node()"/>
</xsl:variable>
<td onmouseover="ChangeBg('{$ChildNodeName}')"
 id="{$ChildNodeName}" onmouseleave="ReturnBg('{$ChildNodeName}')"
 width="150px" align="center"><xsl:value-of select="$ChildNodeName"/></td>
</table>
</xsl:for-each>
</div>
</body>
</html>
</xsl:template>
</xsl:stylesheet>