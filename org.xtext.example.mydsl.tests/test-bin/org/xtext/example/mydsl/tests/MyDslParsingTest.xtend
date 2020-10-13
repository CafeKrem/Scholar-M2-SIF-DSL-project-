/*
 * generated by Xtext 2.23.0
 */
package org.xtext.example.mydsl.tests

import com.google.inject.Inject
import org.eclipse.xtext.testing.InjectWith
import org.eclipse.xtext.testing.extensions.InjectionExtension
import org.eclipse.xtext.testing.util.ParseHelper
import org.junit.jupiter.api.Assertions
import org.junit.jupiter.api.Test
import org.junit.jupiter.api.^extension.ExtendWith
import org.xtext.example.mydsl.myDsl.BinaryOp
import org.xtext.example.mydsl.myDsl.Const
import org.xtext.example.mydsl.myDsl.Load
import org.xtext.example.mydsl.myDsl.Programme
import org.xtext.example.mydsl.myDsl.Save
import org.xtext.example.mydsl.myDsl.Variable

@ExtendWith(InjectionExtension)
@InjectWith(MyDslInjectorProvider)
class MyDslParsingTest {
	@Inject
	ParseHelper<Programme> parseHelper

	@Test
	def void testLoadPrimitiveFunction() {
		val result = parseHelper.parse('''
			load( "pathTo.json" , varName )
		''')
		val loadPrimitive = result.statements.get(0) as Load
		Assertions.assertEquals(loadPrimitive.getPath(), "pathTo.json")
		Assertions.assertEquals(loadPrimitive.varName, "varName")

	}

	@Test
	def void testSimpleConst() {
		val result = parseHelper.parse('''
			1
		''')
		val const = result.statements.get(0) as Const
		Assertions.assertEquals(const.value, 1)
	}

	@Test
	def void testSavePrimitive() {
		val result = parseHelper.parse('''
			save( "pathTo.json" , varName )
		''')
		val SavePrimitive = result.statements.get(0) as Save
		Assertions.assertEquals(SavePrimitive.getPath(), "pathTo.json")
		Assertions.assertEquals(SavePrimitive.varName, "varName")

	}

	@Test
	def void testConstAddition() {
		val result = parseHelper.parse('''
			1 + 2 
		''')
		val addition = result.statements.get(0) as BinaryOp
		Assertions.assertEquals((addition.left as Const).value, 1)
		Assertions.assertEquals((addition.right as Const).value, 2)
	}
	
	@Test
	def void testVarAddition(){
		val result = parseHelper.parse('''
			a + b 
		''')
		val addition = result.statements.get(0) as BinaryOp
		Assertions.assertEquals((addition.left as Variable).varName, "a")
		Assertions.assertEquals((addition.right as Variable).varName, "b")
	}
	@Test
	def void testSubstraction(){
		val result = parseHelper.parse('''
			a - 1 
		''')
		val sub = result.statements.get(0) as BinaryOp
		Assertions.assertEquals(sub.op , "-")
	}
	
	@Test
	def void testTime(){
		val result = parseHelper.parse('''
			a * 1 
		''')
		val sub = result.statements.get(0) as BinaryOp
		Assertions.assertEquals(sub.op , "*")
	}
	
	@Test
	def void testDiv(){
		val result = parseHelper.parse('''
			a / 1 
		''')
		val sub = result.statements.get(0) as BinaryOp
		Assertions.assertEquals(sub.op , "/")
	}
	
	@Test
	def void testcomplexExpression(){
		val result = parseHelper.parse('''
			(a + 1) * 2 
		''')
		val multExp = result.statements.get(0) as BinaryOp
		Assertions.assertEquals(multExp.op , "*")
		Assertions.assertEquals((multExp.left as BinaryOp).op , "+")
		Assertions.assertEquals((multExp.right as Const).value , 2) 
	}
}
