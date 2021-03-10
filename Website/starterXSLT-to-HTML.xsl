<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:math="http://www.w3.org/2005/xpath-functions/math"
    exclude-result-prefixes="xs math"
    version="3.0">
    
    <xsl:output method="xhtml" encoding="utf-8" doctype-system="about:legacy-compat"
        omit-xml-declaration="yes"/>  
    <!-- How do you have one XSLT file export multiple HTML files? -->
    <!-- Why is this not working? Tag nest goes like:
    TEI
        teiHeader
            (stuff)
        text
            group
                text
                    body
                        pb+
                        div+
    
    But none of my calls even work. Even the count() down below doesn't give me anything for counting TEI or TEI/text. :( 
    -->
    
    <xsl:template match="/">
        <html>
            <head>
                <title>Harambee Dinner Programs</title>
                <link type="text/css" href="style.css" rel="stylesheet"/>
            </head>
            <body>
                <xsl:comment>#include virtual="menu.html" </xsl:comment>
                <p><xsl:value-of select="count(TEI/text)"/></p>
                <div><xsl:apply-templates select="//TEI/text/group/text/body"/></div>
            </body>
        </html>
    </xsl:template>
    
    <xsl:template match="TEI/text/group/text/body">
        <h1>Harambee Dinner - <xsl:value-of select="//div[1]/date"/></h1>
    </xsl:template>
    
</xsl:stylesheet>