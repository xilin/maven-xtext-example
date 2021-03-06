package my.mavenized.postprocessing

import org.eclipse.xtext.xtext.ecoreInference.IXtext2EcorePostProcessor
import org.eclipse.xtext.GeneratedMetamodel
import org.eclipse.emf.ecore.EPackage
import org.eclipse.emf.ecore.EClass
import org.eclipse.emf.ecore.EcoreFactory
import org.eclipse.emf.ecore.EcorePackage
import org.eclipse.emf.codegen.ecore.genmodel.GenModelPackage
import org.eclipse.emf.common.util.BasicEMap

class HeroLanguagePostProcessor implements IXtext2EcorePostProcessor {
	
	override process(GeneratedMetamodel metamodel) {
		metamodel.EPackage.process
	}
	
	def process(EPackage p) {
		for (c : p.EClassifiers.filter(typeof(EClass))) {
			if (c.name == "SuperHero") {
				c.handle
			}
		}
	}
	
	def handle(EClass c) {
		val op = EcoreFactory::eINSTANCE.createEOperation
        op.name = "getHeroName"
        op.EType = EcorePackage::eINSTANCE.EString
        val body = EcoreFactory::eINSTANCE.createEAnnotation
        body.source = GenModelPackage::eNS_URI
        val map = EcoreFactory::eINSTANCE.create(EcorePackage::eINSTANCE.getEStringToStringMapEntry()) as BasicEMap$Entry<String,String>
        map.key = "body"
        map.value = "return getName() + \" \";"
        body.details.add(map)
        op.EAnnotations += body
        c.EOperations += op
	}
	
}