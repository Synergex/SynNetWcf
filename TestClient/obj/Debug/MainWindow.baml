   M S B A M L   `   `   `  ����E  ATestClient, Version=1.0.0.0, Culture=neutral, PublicKeyToken=null'clr-namespace:TestClient
TestClient  5          TestClient.MainWindow   5   	   \ XPresentationFramework, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35R NWindowsBase, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35W SPresentationCore, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35D 9http://schemas.microsoft.com/winfx/2006/xaml/presentation    5      R NSystem.Xaml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089:x,http://schemas.microsoft.com/winfx/2006/xaml     5      *localclr-namespace:TestClient     5      $	��700��5       $	��900��6-     � WindowStartupLocation$  CenterScreen=�69    � Title 6   �� *
AppTitle+ � DataContext 5         TestClient.ViewModel  5   
   .��5      �  � RowDefinitions 5   
   �� 5      $
��Auto �6   �� 5      $��* �6   �� 5      $��* �6   �� 5      $
��Auto �6   .+�5   
   �� $��10q�6    �� Orientation$ 
Horizontal=�6!   .+�5      �� $��Supplier��6   �� 5       �� DisplayMemberPath$
 Name��6p   $	��300��6�   ��6   �� *	Suppliers+ �� SelectedItem 69   �� *SelectedSupplier+ �� Mode$ TwoWay=�6�   5      &   System.Windows.Controls.DataGrid  5   
   $��1��6      AutoGenerateColumns .  	   
IsReadOnly	 . 
   SelectionMode$
 Single=�6�   $��10q�6�   ��6    �� *Parts+ 6>   �� *SelectedPart+$ TwoWay=�   Columns 5      0  *System.Windows.Controls.DataGridTextColumn  5      ,  &System.Windows.Controls.DataGridColumn   Header$ Part ID��6%   1  +System.Windows.Controls.DataGridBoundColumn   Binding 66   �� *Id+  5      $ Description��6%    6:   �� *Description+  5      $ Product Group��6%    6<   �� *	Groupid+  5      $ Supplier��6%    67   �� *
Supplierid+5      � 5!   
   $��2��6   $��10q�6    6(   �� *SelectedPart+ 5#      �� 5$      $
��Auto �6    �� 5%      $
��Auto �6    �� 5&      $
��Auto �6    �� 5'      $
��Auto �6    �� 5(      $
��Auto �6    �� 5)      $
��Auto �6    �� 5*      $��* �6     � ColumnDefinitions 5-      �� 5.      $
��Auto �6#   �� 5/      $
��Auto �6#   �� 50      $��* �6#   .+�53      �� $��0��6   $��0��6!   $��Product Code��61   �� 54      $��0��6   $��1��6#    �� 
IsReadOnly . ��63   �� *Id+6G   �� 56      $��1��6   $��0��6!   $��Product Group��61   �� 57      $��1��6   $��1��6#    . ��63   �� *	Groupid+6L   �� 59      $��2��6   $��0��6!   $��Description��61   �� 5:      $��2��6   $��1��6#    . ��63   �� *Description+6P   �� 5<      $��3��6   $��0��6!   $��Stock On Hand��61   �� 5=      $��3��6   $��1��6#    . ��63   �� *
Quantity+6M   �� 5?      $��4��6   $��0��6!   $��
Cost Price��61   �� 5@      $��4��6   $��1��6#    . ��63   �� *	CostPrice+6N   �� 5B      $��5��6   $��0��6!   $
��Info��61   �� 5C      $��5��6   $��1��6#    . ��63   �� *TechnicalInfo+6R   5E      �� 5G   
   $��3��6   
���  ��$��10q�62   ��6>   �� *ErrorMessage+5I      5K      