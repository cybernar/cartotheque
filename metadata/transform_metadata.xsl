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

        <xsl:apply-templates select="/gmd:MD_Metadata/gmd:identificationInfo/gmd:MD_DataIdentification/gmd:citation/gmd:CI_Citation/gmd:date"/>

        <p>Auteurs 
          <xsl:value-of select="/gmd:MD_Metadata/gmd:identificationInfo/gmd:MD_DataIdentification/gmd:credit/gco:CharacterString"/>
        </p>

        <xsl:apply-templates select="/gmd:MD_Metadata/gmd:dataQualityInfo/gmd:DQ_DataQuality/gmd:lineage/gmd:LI_Lineage/gmd:statement"/>

        <p>ID document
          <xsl:value-of select="/gmd:MD_Metadata/gmd:identificationInfo/gmd:MD_DataIdentification/gmd:citation/gmd:CI_Citation/gmd:identifier/gmd:MD_Identifier/gmd:code/gco:CharacterString"/>
        </p>
        
        <h3>Aperçu</h3>
        <img>
          <xsl:attribute name="src">
            <xsl:value-of select="/gmd:MD_Metadata/gmd:identificationInfo/gmd:MD_DataIdentification/gmd:graphicOverview[1]/gmd:MD_BrowseGraphic/gmd:fileName/gco:CharacterString"/>
          </xsl:attribute>
        </img>

        <h3>Mots clés</h3>
        <xsl:apply-templates select="/gmd:MD_Metadata/gmd:identificationInfo/gmd:MD_DataIdentification/gmd:descriptiveKeywords"/>
        
        <h3>Etendue</h3>
        
        <h3>Accès au téléchargement</h3>
        <xsl:apply-templates select="/gmd:MD_Metadata/gmd:distributionInfo/gmd:MD_Distribution/gmd:transferOptions/gmd:MD_DigitalTransferOptions/gmd:onLine"/>
        <xsl:apply-templates select="/gmd:MD_Metadata/gmd:identificationInfo/gmd:MD_DataIdentification/gmd:pointOfContact[1]/gmd:CI_ResponsibleParty"/>
        <xsl:apply-templates select="/gmd:MD_Metadata/gmd:identificationInfo/gmd:MD_DataIdentification/gmd:resourceConstraints"/>

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

  <!-- Template LIEN -->

  <xsl:template match="gmd:onLine">
    <span class="attr">Lien <xsl:value-of select="position()" /></span>
    <xsl:value-of select="gmd:CI_OnlineResource/gmd:description/gco:CharacterString" />
    <a>
      <xsl:attribute name="href">
        <xsl:value-of select="gmd:CI_OnlineResource/gmd:linkage/gmd:URL" />
      </xsl:attribute>
      <xsl:value-of select="gmd:CI_OnlineResource/gmd:linkage/gmd:URL" />
    </a>
  </xsl:template>

  <!-- Template EMAIL RESPONSABLE -->

  <xsl:template match="gmd:CI_ResponsibleParty">
    <p>
      <span class="attr">Contact pour la ressource</span>
      <xsl:value-of select="gmd:contactInfo/gmd:CI_Contact/gmd:address/gmd:CI_Address/gmd:electronicMailAddress/gco:CharacterString" />
    </p>
  </xsl:template>

  <!-- Template CONDITIONS UTILISATION -->
  <xsl:template match="gmd:resourceConstraints">
    <p><span class="attr">Condition d'utilisation</span>
      <xsl:choose>
        <xsl:when test="gmd:MD_LegalConstraints/gmd:accessConstraints/gmd:MD_RestrictionCode/@codeListValue='intellectualPropertyRights'">droits de propriété intectuelle</xsl:when>
        <xsl:otherwise>autres</xsl:otherwise>
      </xsl:choose>
    </p>
  </xsl:template>

</xsl:stylesheet>