package cup.example;

import java.util.ArrayList;
import java.util.List;

public class MultiTreeNode {
	
	private String data;
	private String extraData;
	private ArrayList<MultiTreeNode> children;
	
	public String getData() {
		return data;
	}

	public void setData(String data) {
		this.data = data;	
		
	}
	
	public String getExtraData() {
		return extraData;
	}
	
	public MultiTreeNode(String data, String extraData) {
		this.data = data;
		this.extraData = extraData;
		children = new ArrayList<MultiTreeNode>();
	}
	
	public MultiTreeNode(String data) {
		this.data = data;
		this.extraData = "";
	}

	
	public void addChild(MultiTreeNode child) {
		this.children.add(child);
	}
	
	public void printNode(int level)
	{
		for(int i = 0; i < level; i++) {
			System.out.print(" ");
		}
		System.out.print(data);
		if(extraData != null && extraData.length() > 0) {
			System.out.print("  -   " + extraData + "  -  ");
		}
		System.out.println("");
	
		for(MultiTreeNode multiTreeNode : children) {
			multiTreeNode.printNode(level + 1);
		}
	}
	
//	public static MultiTreeNode createTagNode(MultiTreeNode tagName) {
//		MultiTreeNode createdNode = new MultiTreeNode("Tag");
//		createdNode.addChild(tagName);
//		return createdNode;
//	}
}
