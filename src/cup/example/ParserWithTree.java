package cup.example;

public class ParserWithTree extends Parser{

	public ParserWithTree() 
	{
		super();
	}
	
	
	//creating tag node
	protected MultiTreeNode createTagNode(MultiTreeNode tagName, String value) 
	{ 
		MultiTreeNode newNode = new MultiTreeNode("tag name", value);
		newNode.addChild(tagName);
		return newNode;
	}
	
	//creating attribute node
 	protected MultiTreeNode createAttributeNode(MultiTreeNode attr, String value) 	
 	{ 
 		MultiTreeNode newNode = new MultiTreeNode("attribute node");
 		newNode.addChild(attr);
 		return newNode; 
 	}
 	
 	
	//creating content node
 	protected MultiTreeNode createContentNode(MultiTreeNode content) 	
 	{ 
 		MultiTreeNode newNode = new MultiTreeNode("content node");
 		newNode.addChild(content);
 		return newNode; 
 	}
 	
 	
 	
	//creating attribute node
 	protected MultiTreeNode createTagNodeWithAttributesNameAndValue(MultiTreeNode attrName, MultiTreeNode attrValue) 	
 	{ 
 		MultiTreeNode newNode = new MultiTreeNode("Attribute");
 		newNode.addChild(attrName);
 		return newNode; 
 	}
 	
	//creating attribute node
 	protected MultiTreeNode createTagNodeWithAttributesAndContent(MultiTreeNode attrName, MultiTreeNode attrValue) 	
 	{ 
 		MultiTreeNode newNode = new MultiTreeNode("Attribute");
 		newNode.addChild(attrName);
 		return newNode; 
 	}

 	
 	protected MultiTreeNode createHeadAndBodyTags(MultiTreeNode headTag, MultiTreeNode bodyTag) 	
 	{ 
 		MultiTreeNode newNode = new MultiTreeNode("Attribute");
 		newNode.addChild(headTag);
 		newNode.addChild(bodyTag);
 		return newNode; 
 	}
 	
 	protected MultiTreeNode createAttributeNameNode(MultiTreeNode attributeName) 	
 	{ 
 		MultiTreeNode newNode = new MultiTreeNode("AttributeName");
 		newNode.addChild(attributeName);
 		return newNode; 
 	}
 	
 	protected MultiTreeNode  createTagAndContentNode(MultiTreeNode tagName, MultiTreeNode content) 	
 	{ 
 		MultiTreeNode newNode = new MultiTreeNode("Tag and Content Node");
 		newNode.addChild(tagName);
 		newNode.addChild(content);
 		return newNode; 
 	}
 	
 	protected MultiTreeNode  createTagsAndContentNode(MultiTreeNode tagName, MultiTreeNode tagName2, MultiTreeNode content)
 	{ 
 		MultiTreeNode newNode = new MultiTreeNode("Tags and Content Node");
 		newNode.addChild(tagName);
 		newNode.addChild(tagName2);
 		newNode.addChild(content);
 		return newNode; 
 	}
 	
}
