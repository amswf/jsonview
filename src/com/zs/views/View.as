package com.zs.views
{
	import flash.events.Event;
	
	import org.aswing.BorderLayout;
	import org.aswing.JButton;
	import org.aswing.JPanel;
	import org.aswing.JScrollPane;
	import org.aswing.JTextArea;
	import org.aswing.JTree;
	import org.aswing.LayoutManager;
	import org.aswing.SoftBoxLayout;
	import org.aswing.border.TitledBorder;
	import org.aswing.geom.IntDimension;
	import org.aswing.tree.DefaultMutableTreeNode;
	import org.aswing.tree.DefaultTreeModel;
	import org.aswing.tree.TreeNode;
	import org.aswing.tree.TreePath;
	
	public class View extends JPanel
	{
		private var treeScroll:JScrollPane;
		private var button:JButton = new JButton('查看json');
		private var textarea:JTextArea = new JTextArea();
		private var tree:JTree = new JTree();
		
		public function View()
		{
			super(new SoftBoxLayout(SoftBoxLayout.Y_AXIS));
			
			tree.setModel(null);
			treeScroll = new JScrollPane(tree);
			treeScroll.setPreferredSize(new IntDimension(480,500));
			treeScroll.setBorder(new TitledBorder());
			this.append(treeScroll);
			
			button.setPreferredHeight(28);
			button.addActionListener(parse);
			this.append(button);
			
			this.textarea.getTextField().wordWrap = true;
			this.textarea.setPreferredHeight(130);
			var textScroll:JScrollPane = new JScrollPane(textarea);
			this.append(textScroll);
		}
		
		private function parse(e:Event):void{
			try{
				var data:Object = JSON.parse(this.textarea.getText());
				
				var root:* = new DefaultMutableTreeNode('JSON');
				this.creatTree(data,root);
				tree.setModel(new DefaultTreeModel(root));
				expandAll(tree,new TreePath([tree.getModel().getRoot()]));
			}catch(e:Error){
				root = new DefaultMutableTreeNode('无效数据');
				this.creatTree(data,root);
				tree.setModel(new DefaultTreeModel(root));
			}
		}
		
		private function expandAll(tree:JTree,parent:TreePath,expand:Boolean=true):void {
			var node:TreeNode = TreeNode(parent.getLastPathComponent());
			if (node.getChildCount() > 0) {
				for (var i:* in node.children()) {
					expandAll(tree, parent.pathByAddingChild(node.children()[i]), expand);
				}
			}
			if (expand) {
				tree.expandPath(parent);
			} else {
				tree.collapsePath(parent);
			}
		}
		
		private function creatTree(data:Object,root:DefaultMutableTreeNode):void{
			for(var i:String in data){
				if(String(typeof data[i]) == 'object'){
					var obj:* = new DefaultMutableTreeNode(i);
					root.append(obj);
					creatTree(data[i],obj);
				}else{
					root.append(new DefaultMutableTreeNode(i+'：'+data[i]));
				}
			}
		}
	}
}