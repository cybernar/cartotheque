<?xml version="1.0"?>
<xsl:stylesheet version="1.0"
xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
xmlns:gmd="http://www.isotc211.org/2005/gmd" 
xmlns:gco="http://www.isotc211.org/2005/gco" 
xmlns:gmx="http://www.isotc211.org/2005/gmx" 
xmlns:gml="http://www.opengis.net/gml/3.2">

  <xsl:output method="html" />

  <!-- Template FICHE -->
  <xsl:template match="/">
    <html>
      <head>
        <title>
          <xsl:value-of select="/gmd:MD_Metadata/gmd:fileIdentifier/gco:CharacterString"/>
        </title>
      </head>
      <body>
        <h2>
          <xsl:value-of select="/gmd:MD_Metadata/gmd:identificationInfo/gmd:MD_DataIdentification/gmd:citation/gmd:CI_Citation/gmd:title/gco:CharacterString"/>
        </h2>

        <h3>A propos de cette carte</h3>
        <p>Résumé 
          <xsl:value-of select="/gmd:MD_Metadata/gmd:identificationInfo/gmd:MD_DataIdentification/gmd:abstract/gco:CharacterString"/>
        </p>

        <p>Echelle 1/
          <xsl:value-of select="/gmd:MD_Metadata/gmd:identificationInfo/gmd:MD_DataIdentification/gmd:spatialResolution/gmd:MD_Resolution/gmd:equivalentScale/gmd:MD_RepresentativeFraction/gmd:denominator/gco:Integer"/>
        </p>

        <p>++ test date ++</p>
        <xsl:apply-templates select="/gmd:MD_Metadata/gmd:identificationInfo/gmd:MD_DataIdentification/gmd:citation/gmd:CI_Citation/gmd:date"/>

        <p>Auteurs 
          <xsl:value-of select="/gmd:MD_Metadata/gmd:identificationInfo/gmd:MD_DataIdentification/gmd:credit/gco:CharacterString"/>
        </p>

        <xsl:apply-templates select="/gmd:MD_Metadata/gmd:dataQualityInfo/gmd:DQ_DataQuality/gmd:lineage/gmd:LI_Lineage/gmd:statement"/>

        <p>ID document
          <xsl:value-of select="/gmd:MD_Metadata/gmd:identificationInfo/gmd:MD_DataIdentification/gmd:citation/gmd:CI_Citation/gmd:identifier/gmd:MD_Identifier/gmd:code/gco:CharacterString"/>
        </p>
        
        <h3>Mots clés</h3>
        <xsl:apply-templates select="/gmd:MD_Metadata/gmd:identificationInfo/gmd:MD_DataIdentification/gmd:descriptiveKeywords"/>
        
        <h3>Etendue</h3>
        
        <h3>Accès au téléchargement</h3>

      </body>
    </html>
  </xsl:template>

  <!-- Template DATE -->
  <xsl:template match="gmd:date">
    <p><span>
      <xsl:choose>
        <xsl:when test="gmd:CI_Date/gmd:dateType/gmd:CI_DateTypeCode/@codeListValue='publication'">Date de publication</xsl:when>
        <xsl:when test="gmd:CI_Date/gmd:dateType/gmd:CI_DateTypeCode/@codeListValue='creation'">Date de création</xsl:when>
      </xsl:choose>
    </span>
    <xsl:value-of select="gmd:CI_Date/gmd:date/gco:Date"/></p>
  </xsl:template>

  <!-- Template REALISATION -->
  <xsl:template match="gmd:statement">
    <p>Réalisation <xsl:value-of select="gco:CharacterString" /></p>
  </xsl:template>

  <!-- Template MOTS CLES THESAURUS -->
  <xsl:template match="gmd:descriptiveKeywords">
    <p>
      <xsl:choose>
        <xsl:when test="gmd:MD_Keywords/gmd:thesaurusName">
          <xsl:value-of select="gmd:MD_Keywords/gmd:thesaurusName/gmd:CI_Citation/gmd:title/gco:CharacterString" />
        </xsl:when>
        <xsl:otherwise>AUTRE</xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="gmd:MD_Keywords/gmd:keyword"/>      
    </p>
  </xsl:template>

  <!-- Template MOT CLE -->
  <xsl:template match="gmd:keyword">
    <span><xsl:value-of select="gco:CharacterString" /></span>
  </xsl:template>

</xsl:stylesheet>