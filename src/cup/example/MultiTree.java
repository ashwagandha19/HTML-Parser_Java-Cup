package cup.example;

import java.util.List;

public class MultiTree {
	
	private MultiTreeNode treeRoot = null;
	private int nodesCount = 0;
	
	//getter pentru nr de noduri
	public int getNodesCount() {
		return nodesCount;
	}
	
	public MultiTreeNode create(String rootData) throws Exception
	{	
		System.out.println("CALLED CREATE TREE FUNCTION");
		
		//verific daca a fost creat
		if (treeRoot != null)
		{
			throw new Exception("The three has already been created");			
		}
		
		//creez nodul root
		treeRoot = new MultiTreeNode(rootData);
		nodesCount = 1;
		return treeRoot;
	}
	
	public MultiTreeNode create(String rootData, MultiTreeNode child) throws Exception
	{
		MultiTreeNode createdNode = create(rootData);
		treeRoot.addChild(child);
		//nodesCount = treeRoot.getDescendentsCount();
		return createdNode;
	}
	
	public MultiTreeNode addChildNode(MultiTreeNode child)
	{		
		treeRoot.addChild(child);
		//nodesCount = getNodesCount() + child.getDescendentsCount();
		return child;
	}
	
	
	public void initializeTree(MultiTreeNode root) {
		this.treeRoot = root;
	}
	
	public void printTree() {
		if(treeRoot == null) {
			System.out.println("The tree was no created yet");
			return;
		}
		
		treeRoot.printNode(0);
		System.out.println("Toal elements: " + nodesCount);
	}

}
